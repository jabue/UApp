package ca.evtechnology.welcomepageapp;

import android.os.AsyncTask;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.amazonaws.mobileconnectors.lambdainvoker.*;
import com.amazonaws.auth.CognitoCachingCredentialsProvider;
import com.amazonaws.regions.Regions;

public class MeMainActivity extends ActionBarActivity {

    private final String TAG = "MeMainActivity";
    private Button registerEmailBtn;
    private Button registerFbBtn;
    private RelativeLayout relLayout;

    private int USERID_TEXT = 500;
    private int PASSWORD_TEXT = 501;
    private int SUBMIT_EMAIL_BTN = 502;

    @Override
    protected void onCreate(Bundle savedInstanceState) {


        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_me_main);

        relLayout = (RelativeLayout) findViewById(R.id.RegisterPage);
        registerEmailBtn = (Button) findViewById(R.id.register_email_btn);
        //registerFbBtn = (Button) findViewById(R.id.register_fb_btn);

        registerEmailBtn.setOnClickListener(onClick());
    }

    private View.OnClickListener onClick() {
        return new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                relLayout.addView(createNewTextView("your email", 0));
                relLayout.addView(createNewTextView("Nickname", 1));
                relLayout.addView(createNewButtonView("Submit"));
            }
        };
    }

    private TextView createNewTextView(String text, int pos) {
        final RelativeLayout.LayoutParams lparams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
        final EditText editText = new EditText(this);

        switch (pos)
        {
            case 0:
                lparams.addRule(RelativeLayout.BELOW, R.id.register_email_btn);
                editText.setId(USERID_TEXT);
                break;
            case 1:

                lparams.addRule(RelativeLayout.BELOW, USERID_TEXT);
                editText.setId(PASSWORD_TEXT);
                break;
        }

        editText.setGravity(Gravity.LEFT);
        editText.setLayoutParams(lparams);
        editText.setHint(text);


        return editText;
    }

    private Button createNewButtonView(String text){
        final RelativeLayout.LayoutParams lparams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);


        lparams.addRule(RelativeLayout.BELOW, PASSWORD_TEXT);
        lparams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        Button button = new Button(this);
        button.setText(text);
        button.setLayoutParams(lparams);
        button.setId(SUBMIT_EMAIL_BTN);

        button.setOnClickListener(onClickSubmitEmail());

        final RelativeLayout.LayoutParams lparams1 = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
        lparams1.addRule(RelativeLayout.BELOW, SUBMIT_EMAIL_BTN);
        registerFbBtn.setLayoutParams(lparams1);
        return button;
    }

    private View.OnClickListener onClickSubmitEmail() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText etEmail, etNickName;
                etEmail = (EditText)findViewById(USERID_TEXT);
                etNickName =(EditText)findViewById(PASSWORD_TEXT);
                Log.d(TAG, "submit email:" + etEmail.getText() + ", " + etNickName.getText());

                // Create an instance of CognitoCachingCredentialsProvider
                CognitoCachingCredentialsProvider cognitoProvider = new CognitoCachingCredentialsProvider(
                        MeMainActivity.this.getApplicationContext(), "us-east-1:cab334cf-8514-4060-82e7-13afbdd331f5", Regions.US_EAST_1);

                // Create LambdaInvokerFactory, to be used to instantiate the Lambda proxy.
                LambdaInvokerFactory factory = new LambdaInvokerFactory(MeMainActivity.this.getApplicationContext(),
                        Regions.US_EAST_1, cognitoProvider);

                // Create the Lambda proxy object with a default Json data binder.
                // You can provide your own data binder by implementing
                // LambdaDataBinder.
                final MyInterface myInterface = factory.build(MyInterface.class);

                NameInfo nameInfo = new NameInfo(etEmail.getText().toString(), etNickName.getText().toString());
                // The Lambda function invocation results in a network call.
                // Make sure it is not called from the main thread.
                new AsyncTask<NameInfo, Void, String>() {
                    @Override
                    protected String doInBackground(NameInfo... params) {
                        // invoke "echo" method. In case it fails, it will throw a
                        // LambdaFunctionException.
                        try {
                            return myInterface.simpleWriteDynamoDB(params[0]);
                        } catch (LambdaFunctionException lfe) {
                            Log.e("Tag", "Failed to invoke echo", lfe);
                            return null;
                        }
                    }

                    @Override
                    protected void onPostExecute(String result) {
                        if (result == null) {
                            return;
                        }

                        // Do a toast
                        Toast.makeText(MeMainActivity.this, result, Toast.LENGTH_LONG).show();
                    }
                }.execute(nameInfo);
            }
        };
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_me_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void registerByEmail(View view){
        Log.d(TAG, "start register by email.");
        RelativeLayout linLayout = new RelativeLayout(this);
        RelativeLayout.LayoutParams lpView = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);

        TextView tv = new TextView(this);
        //tv.setHint("Type in your email");
        tv.setText("Type in your email");
        tv.setLayoutParams(lpView);
        linLayout.addView(tv);




    }
}
