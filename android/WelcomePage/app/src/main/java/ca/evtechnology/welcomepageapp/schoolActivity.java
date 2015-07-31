package ca.evtechnology.welcomepageapp;

import android.app.ActionBar;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.provider.ContactsContract;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;


public class schoolActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_school);

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB){
            ActionBar actionBar = getActionBar();
           // actionBar.setDisplayHomeAsUpEnabled(true);
        }

        Uri uri = getIntent().getData();
        Cursor cursor = getContentResolver().query(uri, null, null, null, ContactsContract.Contacts.DISPLAY_NAME);
        if (cursor == null) {
            finish();
        } else {
            cursor.moveToFirst();

            TextView word = (TextView) findViewById(R.id.word);
            TextView definition = (TextView) findViewById(R.id.definition);

            int wIndex = cursor.getColumnIndexOrThrow(DictionaryDatabase.KEY_WORD);
            int dIndex = cursor.getColumnIndexOrThrow(DictionaryDatabase.KEY_DEFINITION);

            word.setText(cursor.getString(wIndex));
            definition.setText(cursor.getString(dIndex));
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_school, menu);
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
}
