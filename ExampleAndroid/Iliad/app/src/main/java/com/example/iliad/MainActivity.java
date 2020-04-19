package com.example.iliad;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebChromeClient;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    public WebView webb;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final ProgressDialog progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Loading Data...");
        progressDialog.setCancelable(false);
        webb = (WebView) findViewById(R.id.webPage);
        WebSettings webs = webb.getSettings();
        webs.setJavaScriptEnabled(true);
        webb.getSettings().setAppCachePath(getApplicationContext().getFilesDir().getAbsolutePath() + "/cache");
        webb.getSettings().setDatabasePath(getApplicationContext().getFilesDir().getAbsolutePath() + "/databases");
        webb.loadUrl("https://www.iliad.it/account/");
        webb.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                return true;
            }
        });

        webb.setWebChromeClient(new WebChromeClient() {
            public void onProgressChanged(WebView view, int progress) {
                if (progress < 100)
                    progressDialog.show();
                if (progress == 100)
                    progressDialog.dismiss();
            }
        });

        webb.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                if (keyCode == KeyEvent.KEYCODE_BACK && event.getAction()
                        == MotionEvent.ACTION_UP && webb.canGoBack()) {
                    //handler.sendEmptyMessage(1);
                    webb.goBack();
                    return true;
                }
                return false;
            }
        });
    }

    @Override
    public void onBackPressed() {
        if(webb.canGoBack())
            webb.goBack();
        else
            super.onBackPressed();
    }
}
