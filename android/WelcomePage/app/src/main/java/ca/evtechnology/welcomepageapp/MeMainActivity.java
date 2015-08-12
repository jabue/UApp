package ca.evtechnology.welcomepageapp;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.renderscript.Script;
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

    private int RegisterOrLogin = 1; // 0: login; 1: register
    private String AsyncResult = null;

    //MyAsyncTask asyncTask =new MyAsyncTask();

    @Override
    protected void onCreate(Bundle savedInstanceState) {


        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_me_main);

       // relLayout = (RelativeLayout) findViewById(R.id.RegisterPage);
        //registerEmailBtn = (Button) findViewById(R.id.register_email_btn);
        //registerFbBtn = (Button) findViewById(R.id.register_fb_btn);

        //registerEmailBtn.setOnClickListener(onClick());
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

        //button.setOnClickListener(onClickSubmitEmail());

        final RelativeLayout.LayoutParams lparams1 = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
        lparams1.addRule(RelativeLayout.BELOW, SUBMIT_EMAIL_BTN);
        registerFbBtn.setLayoutParams(lparams1);
        return button;
    }
/*
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
*/
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

    public void signUp(View view){
        Button loginBtn = null;
        Button signUpBtn = null;

        RegisterOrLogin = 1; // it is signup when submit.
        loginBtn = (Button) findViewById(R.id.btn_login);
        signUpBtn = (Button) findViewById(R.id.btn_signup);

        loginBtn.setBackgroundColor(view.getContext().getResources().getColor(R.color.background_material_light));
        loginBtn.setTextColor(view.getContext().getResources().getColor(R.color.styleColor));

        signUpBtn.setBackgroundColor(view.getContext().getResources().getColor(R.color.styleColor));
        signUpBtn.setTextColor(view.getContext().getResources().getColor(R.color.white));

        // Initiate input box
        EditText emailTxt = null;
        EditText pwdTxt = null;
        EditText pwdConfirmTxt = null;

        emailTxt = (EditText) findViewById(R.id.editTextEmail);
        emailTxt.setText("");

        pwdTxt = (EditText) findViewById(R.id.editTextPwd);
        pwdTxt.setText("");

        pwdConfirmTxt = (EditText) findViewById(R.id.editTextPwd2);
        pwdConfirmTxt.setVisibility(View.VISIBLE);



    }

    public void login(View view){
        Button loginBtn = null;
        Button signUpBtn = null;

        RegisterOrLogin = 0; // it is login when submit.
        loginBtn = (Button) findViewById(R.id.btn_login);
        signUpBtn = (Button) findViewById(R.id.btn_signup);

        // set color as focused when button click.
        signUpBtn.setBackgroundColor(view.getContext().getResources().getColor(R.color.background_material_light));
        signUpBtn.setTextColor(view.getContext().getResources().getColor(R.color.styleColor));

        loginBtn.setBackgroundColor(view.getContext().getResources().getColor(R.color.styleColor));
        loginBtn.setTextColor(view.getContext().getResources().getColor(R.color.white));

        // Initiate input box
        EditText emailTxt = null;
        EditText pwdTxt = null;
        EditText pwdConfirmTxt = null;

        emailTxt = (EditText) findViewById(R.id.editTextEmail);
        emailTxt.setText("");

        pwdTxt = (EditText) findViewById(R.id.editTextPwd);
        pwdTxt.setText("");

        pwdConfirmTxt = (EditText) findViewById(R.id.editTextPwd2);
        pwdConfirmTxt.setVisibility(View.INVISIBLE);


    }

    public void submitClick(View view){
        EditText emailTxt = null;
        EditText pwdTxt = null;
        EditText pwdConfirmTxt = null;

        int FLAG_USERID_UNAVIABLE = 0; // flag to indicate if the user_id can be used.

        Log.d(TAG, "sign up submit..");
        emailTxt = (EditText) findViewById(R.id.editTextEmail);

        if (checkEmail(emailTxt.getText().toString()) == false){
            Log.d(TAG, "email is wrong.");
            new AlertDialog.Builder(this)
                    .setTitle("Error")
                    .setMessage("Please type your email.")
                    .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            // do nothing.
                        }
                    })
                    .setIcon(android.R.drawable.ic_dialog_alert)
                    .show();
            return;
        }

        pwdTxt = (EditText) findViewById(R.id.editTextPwd);
        // Create an instance of CognitoCachingCredentialsProvider
        CognitoCachingCredentialsProvider cognitoProvider = new CognitoCachingCredentialsProvider(
                MeMainActivity.this.getApplicationContext(), "us-east-1:cab334cf-8514-4060-82e7-13afbdd331f5", Regions.US_EAST_1);

        // Create LambdaInvokerFactory, to be used to instantiate the Lambda proxy.
        LambdaInvokerFactory factory = new LambdaInvokerFactory(MeMainActivity.this.getApplicationContext(),
                Regions.US_EAST_1, cognitoProvider);
Log.d(TAG, "create LambadInvokerFactroy successfully.");
        // Create the Lambda proxy object with a default Json data binder.
        // You can provide your own data binder by implementing
        // LambdaDataBinder.
        final MyInterface myInterface = factory.build(MyInterface.class);

        NameInfo nameInfo = new NameInfo(emailTxt.getText().toString(), pwdTxt.getText().toString());
        Log.d(TAG, "RegisterOrLogin? " + RegisterOrLogin);
        if(RegisterOrLogin == 1){
            // sign up
            pwdConfirmTxt = (EditText) findViewById(R.id.editTextPwd2);
            Log.d(TAG, "start to register.");
            if (checkPassword(pwdTxt.getText().toString(), pwdConfirmTxt.getText().toString()) == false){
                Log.d(TAG, "password is wrong.");
                new AlertDialog.Builder(this)
                        .setTitle("Error")
                        .setMessage("Password does not match.")
                        .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                // do nothing.
                            }
                        })
                        .setIcon(android.R.drawable.ic_dialog_alert)
                        .show();
                return;
            }

            Log.d(TAG, "begin to call lambda..");


            CheckUseridAsyncTask someTask = new CheckUseridAsyncTask(getApplicationContext(), nameInfo, new AsyncResponse<String>() {
                @Override
                public void onSuccess(String result) {
                    Toast.makeText(getApplicationContext(), getResources().getString(R.string.signup_succeed), Toast.LENGTH_LONG).show();
                    if( result.equals("NotFound")){ // user name available. go to home page.
                        Intent homeIntent = new Intent(MeMainActivity.this, NewHomeActivity.class);
                        startActivity(homeIntent);
                    }
                    else{ // user name used. ask user change another one.
                        dialog("UApp", getResources().getString(R.string.user_id_unavailable) );
                    }
                }

                @Override
                public void onFailure(Exception e) {
                    Toast.makeText(getApplicationContext(), "ERROR: " + e.getMessage(), Toast.LENGTH_LONG).show();
                }
            });
            someTask.execute();
        }
        else{
            // login
            Log.d(TAG, "start to login.");
            final CheckUseridAsyncTask someTask = new CheckUseridAsyncTask(getApplicationContext(), nameInfo, new AsyncResponse<String>() {
                EditText etPassword = null;

                @Override
                public void onSuccess(String result) {
                    Toast.makeText(getApplicationContext(), "SUCCESS: "+result, Toast.LENGTH_LONG).show();
                    if( result.equals("NotFound")){
                        dialog("UApp", "No such user.");
                    }
                    else{
                        etPassword = (EditText) findViewById(R.id.editTextPwd);
                        if (result.equals(etPassword.getText().toString())){
                            Log.d(TAG, "password right.");
                            Intent homeIntent = new Intent(MeMainActivity.this, NewHomeActivity.class);
                            startActivity(homeIntent);
                        }
                        else {
                            Log.d(TAG, "password wrong");
                            dialog("UApp", getResources().getString(R.string.password_wrong));
                        }
                    }
                }

                @Override
                public void onFailure(Exception e) {
                    Toast.makeText(getApplicationContext(), "ERROR: " + e.getMessage(), Toast.LENGTH_LONG).show();
                }
            });
            someTask.execute();

        }



    }

    private boolean checkEmail(String email){
        if(email ==null || email.isEmpty()){
            return false;
        }
        else{
            Log.d(TAG, "email=|" + email + "|");
            return true;
        }
    }

    protected void dialog(String title, String message) {
        AlertDialog.Builder builder = new AlertDialog.Builder(MeMainActivity.this);
        builder.setMessage(message);
        builder.setTitle(title);
        builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                //MeMainActivity.this.finish();
            }
        });
        builder.create().show();
    }


    private boolean checkPassword(String pwd1, String pwd2){
        if(pwd1 ==null || pwd1.isEmpty()){
            return false;
        }
        Log.d(TAG, "password is " + pwd1);
        if (pwd2 != null)
            Log.d(TAG, "re password is " + pwd2);
        if(pwd1.equals(pwd2)){
            return true;
        }
        else {

            return false;
        }
    }

    void processFinish(String output){
        //this you will received result fired from async class of onPostExecute(result) method.
    }
}
