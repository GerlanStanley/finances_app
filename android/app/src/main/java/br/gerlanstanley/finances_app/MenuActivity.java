package br.gerlanstanley.finances_app;

import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.EventChannel;

public class MenuActivity extends FlutterActivity {
    private static final String CHANNEL = "platform_channel_events/pages";
    private EventChannel.EventSink attachEvent;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.menu_activity);

        new EventChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor(), CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object args, final EventChannel.EventSink events) {
                        System.out.println("onListen");
                        attachEvent = events;
                    }

                    @Override
                    public void onCancel(Object args) {
                        System.out.println("onCancel");
                        attachEvent = null;
                    }
                }
        );

        View tableButton = findViewById(R.id.table_button);
        tableButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                attachEvent.success("/table");
                finish();
            }
        });


        View graphButton = findViewById(R.id.graph_button);
        graphButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                attachEvent.success("/chart");
                finish();
            }
        });
    }
}
