package com.example.iliad;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebChromeClient;
import android.webkit.CookieManager;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.webkit.WebViewDatabase;

public class MainActivity extends AppCompatActivity {

    public WebView webb;
    private static final String TAG = "MainActivity";
    @SuppressLint({"SetJavaScriptEnabled", "WrongViewCast"})
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        webb = (WebView) findViewById(R.id.webPage);
        String url = "https://www.iliad.it/account/";

        final ProgressDialog progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Loading Data...");
        progressDialog.setCancelable(false);

        CookieManager.getInstance().setAcceptCookie(true);
        CookieManager.getInstance().setAcceptThirdPartyCookies(webb, true);
        CookieManager cookieManager = CookieManager.getInstance();
        cookieManager.flush();

        WebSettings webs = webb.getSettings();
        //webs.setJavaScriptEnabled(true);
        webs.setAllowFileAccess(true);
        webs.setSaveFormData(true);

        WebViewDatabase webViewDB = WebViewDatabase.getInstance(getApplicationContext());
        if (webViewDB != null) {
            webb.getSettings().setJavaScriptEnabled(true);
            webb.loadUrl(url);
        } else {
            startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse(url)));
        }

        //webb.getSettings().setAppCacheEnabled(true);
        //webb.getSettings().setCacheMode(WebSettings.LOAD_DEFAULT);
        //webb.loadUrl(url);
        webb.setWebViewClient(new WebViewClient() {});
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
