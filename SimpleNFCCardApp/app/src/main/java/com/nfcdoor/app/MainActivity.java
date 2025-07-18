package com.nfcdoor.app;

import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.cardemulation.CardEmulation;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private static final String PREFS_NAME = "NFCCardPrefs";
    private static final String CARD_UID_KEY = "card_uid";

    private NfcAdapter nfcAdapter;
    private PendingIntent pendingIntent;
    private CardEmulation cardEmulation;

    private TextView cardInfoText;
    private TextView statusText;
    private Button scanButton;
    private Button emulateButton;

    private boolean isEmulating = false;
    private String savedCardUID = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initViews();
        initNFC();
        loadSavedCard();
        updateUI();
    }

    private void initViews() {
        cardInfoText = findViewById(R.id.cardInfoText);
        statusText = findViewById(R.id.statusText);
        scanButton = findViewById(R.id.scanButton);
        emulateButton = findViewById(R.id.emulateButton);

        scanButton.setOnClickListener(v -> startScanning());
        emulateButton.setOnClickListener(v -> toggleEmulation());
    }

    private void initNFC() {
        nfcAdapter = NfcAdapter.getDefaultAdapter(this);

        if (nfcAdapter == null) {
            showToast(getString(R.string.nfc_not_supported));
            emulateButton.setEnabled(false);
            scanButton.setEnabled(false);
            return;
        }
        
        cardEmulation = CardEmulation.getInstance(nfcAdapter);

        int pendingIntentFlags = Build.VERSION.SDK_INT >= Build.VERSION_CODES.S
                ? PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_MUTABLE
                : PendingIntent.FLAG_UPDATE_CURRENT;

        Intent intent = new Intent(this, getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
        pendingIntent = PendingIntent.getActivity(this, 0, intent, pendingIntentFlags);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (nfcAdapter != null) {
            if (!nfcAdapter.isEnabled()) {
                showToast(getString(R.string.nfc_not_enabled));
            }
            IntentFilter tagFilter = new IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED);
            nfcAdapter.enableForegroundDispatch(this, pendingIntent, new IntentFilter[]{tagFilter}, null);
        }
        checkDefaultNfcService();
        updateUI();
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (nfcAdapter != null) {
            nfcAdapter.disableForegroundDispatch(this);
        }
    }

    private void loadSavedCard() {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        savedCardUID = prefs.getString(CARD_UID_KEY, null);
    }

    private void saveCard(String uid) {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        prefs.edit().putString(CARD_UID_KEY, uid).apply();
        savedCardUID = uid;
    }

    private void startScanning() {
        statusText.setText(getString(R.string.place_card_message));
        statusText.setVisibility(View.VISIBLE);
        showToast(getString(R.string.scan_prompt));
    }

    private void toggleEmulation() {
        // This button now primarily guides the user to set the app as default
        if (!isDefaultNfcService()) {
            showToast(getString(R.string.set_as_default_prompt));
            Intent intent = new Intent(Settings.ACTION_NFC_PAYMENT_SETTINGS);
            startActivity(intent);
        } else {
             showToast(isEmulating ? getString(R.string.emulation_stopped) : getString(R.string.emulation_started));
             isEmulating = !isEmulating; // Toggle state
             updateUI();
        }
    }
    
    private void checkDefaultNfcService() {
        isEmulating = isDefaultNfcService();
    }

    private boolean isDefaultNfcService() {
        ComponentName serviceComponent = new ComponentName(this, NFCCardEmulationService.class);
        return cardEmulation.isDefaultServiceForCategory(serviceComponent, CardEmulation.CATEGORY_OTHER);
    }

    private void updateUI() {
        if (savedCardUID != null && !savedCardUID.isEmpty()) {
            cardInfoText.setText(getString(R.string.card_uid, savedCardUID));
            emulateButton.setEnabled(true);
        } else {
            cardInfoText.setText(getString(R.string.no_card_saved));
            emulateButton.setEnabled(false);
        }

        if (isEmulating) {
            emulateButton.setText(getString(R.string.emulation_active));
            statusText.setText(getString(R.string.emulating_message));
            statusText.setVisibility(View.VISIBLE);
            scanButton.setEnabled(false);
        } else {
            emulateButton.setText(getString(R.string.emulate_card));
            statusText.setVisibility(View.GONE);
            scanButton.setEnabled(true);
        }
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (NfcAdapter.ACTION_TAG_DISCOVERED.equals(intent.getAction())) {
            Tag tag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
            if (tag != null) {
                String uidString = bytesToHex(tag.getId());
                saveCard(uidString);
                updateUI();
                statusText.setVisibility(View.GONE);
                showToast(getString(R.string.card_saved, uidString));
            }
        }
    }

    private String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02X", b));
        }
        return sb.toString();
    }

    private void showToast(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }
} 
} 