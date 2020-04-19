package com.example.iliad;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class MainActivity extends AppCompatActivity {

    public WebView webb;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        webb = (WebView)findViewById(R.id.webPage);
        WebSettings webs = webb.getSettings();
        webs.setJavaScriptEnabled(true);
        webb.loadUrl("https://www.iliad.it/account/");
        webb.setWebViewClient(new WebViewClient());
    }

    @Override
    public void onBackPressed() {
        if(webb.canGoBack())
            webb.goBack();
        else
            super.onBackPressed();
    }
}
