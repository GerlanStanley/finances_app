package br.gerlanstanley.finances_app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

public class MenuActivity extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.menu_activity);

        getSupportActionBar().hide();

        Window window = getWindow();

        // clear FLAG_TRANSLUCENT_STATUS flag:
        window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);

        // add FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS flag to the window
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);

        // finally change the color
        window.setStatusBarColor(ContextCompat.getColor(this, R.color.primary));

        View tableButton = findViewById(R.id.table_button);
        tableButton.setOnClickListener(view -> {
            Intent returnIntent = new Intent();
            returnIntent.putExtra("page", "/table");
            setResult(Activity.RESULT_OK, returnIntent);
            finish();
        });


        View graphButton = findViewById(R.id.graph_button);
        graphButton.setOnClickListener(view -> {
            Intent returnIntent = new Intent();
            returnIntent.putExtra("page", "/chart");
            setResult(Activity.RESULT_OK, returnIntent);
            finish();
        });
    }
}
