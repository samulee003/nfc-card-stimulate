package com.nfcdoor.app;

import androidx.appcompat.app.AppCompatActivity;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.cardemulation.CardEmulation;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    
    private static final String PREFS_NAME = "NFCCardPrefs";
    private static final String CARD_UID_KEY = "card_uid";
    
    private NfcAdapter nfcAdapter;
    private PendingIntent pendingIntent;
    private IntentFilter[] intentFilters;
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
        
        scanButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startScanning();
            }
        });
        
        emulateButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toggleEmulation();
            }
        });
    }
    
    private void initNFC() {
        nfcAdapter = NfcAdapter.getDefaultAdapter(this);
        
        if (nfcAdapter == null) {
            showToast(getString(R.string.nfc_not_supported));
            return;
        }
        
        if (!nfcAdapter.isEnabled()) {
            showToast(getString(R.string.nfc_not_enabled));
        }
        
        // Setup pending intent for NFC
        Intent intent = new Intent(this, getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
        pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_MUTABLE);
        
        // Setup intent filters
        IntentFilter tagFilter = new IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED);
        intentFilters = new IntentFilter[]{tagFilter};
        
        // Get card emulation service
        cardEmulation = CardEmulation.getInstance(nfcAdapter);
    }
    
    private void loadSavedCard() {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        savedCardUID = prefs.getString(CARD_UID_KEY, null);
    }
    
    private void saveCard(String uid) {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(CARD_UID_KEY, uid);
        editor.apply();
        savedCardUID = uid;
    }
    
    private void startScanning() {
        statusText.setText(getString(R.string.place_card_message));
        statusText.setVisibility(View.VISIBLE);
        showToast("準備掃描，請將門卡貼近手機");
    }
    
    private void toggleEmulation() {
        if (isEmulating) {
            stopEmulation();
        } else {
            startEmulation();
        }
    }
    
    private void startEmulation() {
        if (savedCardUID == null) {
            showToast("請先掃描門卡");
            return;
        }
        
        ComponentName service = new ComponentName(this, NFCCardEmulationService.class);
        if (cardEmulation.isDefaultServiceForCategory(service, CardEmulation.CATEGORY_OTHER)) {
            isEmulating = true;
            updateUI();
            statusText.setText(getString(R.string.emulating_message));
            statusText.setVisibility(View.VISIBLE);
            showToast(getString(R.string.emulation_started));
        } else {
            showToast("請在 NFC 設定中將此 App 設為預設付款應用程式");
        }
    }
    
    private void stopEmulation() {
        isEmulating = false;
        updateUI();
        statusText.setVisibility(View.GONE);
        showToast(getString(R.string.emulation_stopped));
    }
    
    private void updateUI() {
        if (savedCardUID != null) {
            cardInfoText.setText(getString(R.string.card_uid) + ": " + savedCardUID);
            emulateButton.setEnabled(true);
        } else {
            cardInfoText.setText(getString(R.string.no_card_saved));
            emulateButton.setEnabled(false);
        }
        
        if (isEmulating) {
            emulateButton.setText(getString(R.string.stop_emulation));
            scanButton.setEnabled(false);
        } else {
            emulateButton.setText(getString(R.string.emulate_card));
            scanButton.setEnabled(true);
        }
    }
    
    @Override
    protected void onResume() {
        super.onResume();
        if (nfcAdapter != null) {
            nfcAdapter.enableForegroundDispatch(this, pendingIntent, intentFilters, null);
        }
    }
    
    @Override
    protected void onPause() {
        super.onPause();
        if (nfcAdapter != null) {
            nfcAdapter.disableForegroundDispatch(this);
        }
    }
    
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        
        if (NfcAdapter.ACTION_TAG_DISCOVERED.equals(intent.getAction())) {
            Tag tag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
            if (tag != null) {
                byte[] uid = tag.getId();
                String uidString = bytesToHex(uid);
                
                saveCard(uidString);
                updateUI();
                statusText.setVisibility(View.GONE);
                showToast(getString(R.string.card_saved) + ": " + uidString);
            }
        }
    }
    
    private String bytesToHex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte b : bytes) {
            result.append(String.format("%02X", b));
        }
        return result.toString();
    }
    
    private void showToast(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }
} 