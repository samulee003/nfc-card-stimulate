package com.nfcdoor.app;

import android.nfc.cardemulation.HostApduService;
import android.os.Bundle;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import java.util.Arrays;

public class NFCCardEmulationService extends HostApduService {

    private static final String TAG = "NFCCardEmulationService";
    private static final String PREFS_NAME = "NFCCardPrefs";
    private static final String CARD_UID_KEY = "card_uid";

    // ISO-DEP command for selecting an application (AID).
    private static final byte[] SELECT_APDU_HEADER = {
        (byte) 0x00, // CLA
        (byte) 0xA4, // INS (SELECT)
        (byte) 0x04, // P1 (by name)
        (byte) 0x00, // P2 (first or only occurrence)
    };

    // "OK" status word sent in response to SELECT APDU.
    private static final byte[] SW_OK = {(byte) 0x90, (byte) 0x00};
    
    // "UNKNOWN" status word
    private static final byte[] SW_UNKNOWN = {(byte) 0x6F, (byte) 0x00};

    @Override
    public byte[] processCommandApdu(byte[] commandApdu, Bundle extras) {
        if (commandApdu == null) {
            return SW_UNKNOWN;
        }

        Log.i(TAG, "Received APDU: " + bytesToHex(commandApdu));

        // The first few bytes of the APDU are the header.
        byte[] header = Arrays.copyOfRange(commandApdu, 0, SELECT_APDU_HEADER.length);
        
        // Check if it's a SELECT command.
        if (Arrays.equals(SELECT_APDU_HEADER, header)) {
            Log.i(TAG, "SELECT APDU detected.");

            // Get the saved UID from SharedPreferences
            SharedPreferences prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
            String savedUid = prefs.getString(CARD_UID_KEY, null);

            if (savedUid != null && !savedUid.isEmpty()) {
                byte[] uidBytes = hexStringToByteArray(savedUid);
                Log.i(TAG, "Responding with UID: " + savedUid);
                // In a real scenario, you might have more complex logic here.
                // For this example, we return the UID concatenated with SW_OK.
                return concatArrays(uidBytes, SW_OK);
            } else {
                Log.w(TAG, "No UID saved, cannot respond to SELECT APDU.");
                return SW_UNKNOWN;
            }
        } else {
            Log.w(TAG, "Unknown APDU command.");
            return SW_UNKNOWN;
        }
    }

    @Override
    public void onDeactivated(int reason) {
        Log.i(TAG, "Deactivated: " + reason);
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte b : bytes) {
            result.append(String.format("%02X", b));
        }
        return result.toString();
    }
    
    public static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                                 + Character.digit(s.charAt(i+1), 16));
        }
        return data;
    }

    private byte[] concatArrays(byte[] first, byte[]... rest) {
        int totalLength = first.length;
        for (byte[] array : rest) {
            totalLength += array.length;
        }
        byte[] result = Arrays.copyOf(first, totalLength);
        int offset = first.length;
        for (byte[] array : rest) {
            System.arraycopy(array, 0, result, offset, array.length);
            offset += array.length;
        }
        return result;
    }
} 