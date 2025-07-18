package com.nfcdoor.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.nfc.cardemulation.HostApduService;
import android.os.Bundle;
import android.util.Log;

public class NFCCardEmulationService extends HostApduService {
    
    private static final String TAG = "NFCEmulationService";
    private static final String PREFS_NAME = "NFCCardPrefs";
    private static final String CARD_UID_KEY = "card_uid";
    
    // APDU command constants
    private static final byte[] SELECT_AID_COMMAND = {
        (byte) 0x00, (byte) 0xA4, (byte) 0x04, (byte) 0x00, (byte) 0x06,
        (byte) 0xF0, (byte) 0x39, (byte) 0x41, (byte) 0x48, (byte) 0x14, (byte) 0x81
    };
    
    private static final byte[] SUCCESS_RESPONSE = {(byte) 0x90, (byte) 0x00};
    private static final byte[] ERROR_RESPONSE = {(byte) 0x6F, (byte) 0x00};
    
    @Override
    public byte[] processCommandApdu(byte[] commandApdu, Bundle extras) {
        Log.d(TAG, "Received APDU: " + bytesToHex(commandApdu));
        
        // Get saved card UID
        String savedUID = getSavedCardUID();
        if (savedUID == null) {
            Log.e(TAG, "No saved card UID found");
            return ERROR_RESPONSE;
        }
        
        // Handle SELECT AID command
        if (isSelectAidCommand(commandApdu)) {
            Log.d(TAG, "SELECT AID command received");
            return SUCCESS_RESPONSE;
        }
        
        // Handle GET UID command (custom command)
        if (isGetUidCommand(commandApdu)) {
            Log.d(TAG, "GET UID command received");
            byte[] uidBytes = hexToBytes(savedUID);
            byte[] response = new byte[uidBytes.length + 2];
            System.arraycopy(uidBytes, 0, response, 0, uidBytes.length);
            response[uidBytes.length] = (byte) 0x90;
            response[uidBytes.length + 1] = (byte) 0x00;
            return response;
        }
        
        // For any other command, just return success
        Log.d(TAG, "Unknown command, returning success");
        return SUCCESS_RESPONSE;
    }
    
    @Override
    public void onDeactivated(int reason) {
        Log.d(TAG, "Service deactivated: " + reason);
    }
    
    private boolean isSelectAidCommand(byte[] apdu) {
        if (apdu.length < SELECT_AID_COMMAND.length) {
            return false;
        }
        
        for (int i = 0; i < SELECT_AID_COMMAND.length; i++) {
            if (apdu[i] != SELECT_AID_COMMAND[i]) {
                return false;
            }
        }
        return true;
    }
    
    private boolean isGetUidCommand(byte[] apdu) {
        // Custom command: 00 CA 00 00 00 (GET DATA for UID)
        return apdu.length >= 5 &&
               apdu[0] == (byte) 0x00 &&
               apdu[1] == (byte) 0xCA &&
               apdu[2] == (byte) 0x00 &&
               apdu[3] == (byte) 0x00;
    }
    
    private String getSavedCardUID() {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        return prefs.getString(CARD_UID_KEY, null);
    }
    
    private String bytesToHex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte b : bytes) {
            result.append(String.format("%02X", b));
        }
        return result.toString();
    }
    
    private byte[] hexToBytes(String hex) {
        int len = hex.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                                + Character.digit(hex.charAt(i + 1), 16));
        }
        return data;
    }
} 