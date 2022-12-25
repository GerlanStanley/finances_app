package br.gerlanstanley.finances_app;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "platform_channel_events/activity";
    private MethodChannel.Result result;

    private static final int REQUEST_CODE = 100;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            this.result = result;

                            if (call.method.equals("menu")) {
                                Intent intent = new Intent(this, MenuActivity.class);
                                startActivityForResult(intent, REQUEST_CODE);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            result.success(data.getStringExtra("page"));
        } else {
            result.error("Erro", null, null);
        }
    }
}
