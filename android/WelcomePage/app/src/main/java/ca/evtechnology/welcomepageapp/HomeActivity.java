package ca.evtechnology.welcomepageapp;

import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;


public class HomeActivity extends AppCompatActivity {

    private static final String TAG = "HoemActivity";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        // Get the message from the intent
        Intent intent = getIntent();
        Uri uri = getIntent().getData();
        Cursor cursor = managedQuery(uri, null, null, null, null);

        if (cursor == null) {
            finish();
        } else {
            cursor.moveToFirst();
            int dIndex = cursor.getColumnIndexOrThrow(DictionaryDatabase.KEY_DEFINITION);

            Log.i(TAG, cursor.getString(dIndex));

            setTitle(cursor.getString(dIndex));

        }
       // String message = intent.getStringExtra(SelectCampusActivity.EXTRA_MESSAGE);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_home, menu);
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

    public void goMessage(View view){

        ImageButton btnHome = (ImageButton)findViewById(R.id.button_home);
        btnHome.setImageResource(R.drawable.home);

        ImageButton btnMessage = (ImageButton)findViewById(R.id.button_message);
        btnMessage.setImageResource(R.drawable.messagecolor);

        ImageButton btnDiscover = (ImageButton)findViewById(R.id.button_discover);
        btnDiscover.setImageResource(R.drawable.discover);

        ImageButton btnMe = (ImageButton)findViewById(R.id.button_me);
        btnMe.setImageResource(R.drawable.me);



    }

    public void goHome(View view){

        ImageButton btnHome = (ImageButton)findViewById(R.id.button_home);
        btnHome.setImageResource(R.drawable.homecolor);

        ImageButton btnMessage = (ImageButton)findViewById(R.id.button_message);
        btnMessage.setImageResource(R.drawable.message);

        ImageButton btnDiscover = (ImageButton)findViewById(R.id.button_discover);
        btnDiscover.setImageResource(R.drawable.discover);

        ImageButton btnMe = (ImageButton)findViewById(R.id.button_me);
        btnMe.setImageResource(R.drawable.me);

    }

    public void goDiscover(View view){

        ImageButton btnHome = (ImageButton)findViewById(R.id.button_home);
        btnHome.setImageResource(R.drawable.home);

        ImageButton btnMessage = (ImageButton)findViewById(R.id.button_message);
        btnMessage.setImageResource(R.drawable.message);

        ImageButton btnDiscover = (ImageButton)findViewById(R.id.button_discover);
        btnDiscover.setImageResource(R.drawable.discovercolor);

        ImageButton btnMe = (ImageButton)findViewById(R.id.button_me);
        btnMe.setImageResource(R.drawable.me);

    }

    public void goMe(View view){

        ImageButton btnHome = (ImageButton)findViewById(R.id.button_home);
        btnHome.setImageResource(R.drawable.home);

        ImageButton btnMessage = (ImageButton)findViewById(R.id.button_message);
        btnMessage.setImageResource(R.drawable.message);

        ImageButton btnDiscover = (ImageButton)findViewById(R.id.button_discover);
        btnDiscover.setImageResource(R.drawable.discover);

        ImageButton btnMe = (ImageButton)findViewById(R.id.button_me);
        btnMe.setImageResource(R.drawable.mecolor);

    }
}
