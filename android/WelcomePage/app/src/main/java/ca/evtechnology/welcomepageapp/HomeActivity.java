package ca.evtechnology.welcomepageapp;

import android.content.Context;
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
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class HomeActivity extends AppCompatActivity {

    private static final String TAG = "HoemActivity";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        // Get the message from the intent
        Intent intent = getIntent();
        Uri uri = getIntent().getData();
        //Cursor cursor = managedQuery(uri, null, null, null, null);
        Cursor cursor = getContentResolver().query(uri, null, null, null, null);

        if (cursor == null) {
            finish();
        } else {
            cursor.moveToFirst();
            int dIndex = cursor.getColumnIndexOrThrow(DictionaryDatabase.KEY_DEFINITION);
            setTitle(cursor.getString(dIndex));
        }
        addListenerOnButton();
        displaySchoolHome();

    }

    public   void displaySchoolHome(){

        final ListView listview = (ListView) findViewById(R.id.listView);
        String[] values = new String[] { "Android", "iPhone", "WindowsMobile",
                "Blackberry", "WebOS", "Ubuntu", "Windows7", "Max OS X",
                "Linux", "OS/2", "Ubuntu", "Windows7", "Max OS X", "Linux",
                "OS/2", "Ubuntu", "Windows7", "Max OS X", "Linux", "OS/2" };

        final ArrayList<String> list = new ArrayList<String>();

        for (int i = 0; i < values.length; ++i) {
            list.add(values[i]);
        }
        final StableArrayAdapter adapter = new StableArrayAdapter(this,
                android.R.layout.simple_list_item_1, list);
        listview.setAdapter(adapter);

        listview.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> parent, final View view,
                                    int position, long id) {
                final String item = (String) parent.getItemAtPosition(position);
                view.animate().setDuration(2000).alpha(0)
                        .withEndAction(new Runnable() {
                            @Override
                            public void run() {
                                list.remove(item);
                                adapter.notifyDataSetChanged();
                                view.setAlpha(1);
                            }
                        });
            }

        });

    }

    private  void displayClasslHome(){

        final ListView listview = (ListView) findViewById(R.id.listView);
        String[] values = new String[] { "Rafy", "Ronald", "Cici",
                "David", "Victor", "Aaron", "Maggie", "Edmund" };

        final ArrayList<String> list = new ArrayList<String>();

        for (int i = 0; i < values.length; ++i) {
            list.add(values[i]);
        }
        final StableArrayAdapter adapter = new StableArrayAdapter(this,
                android.R.layout.simple_list_item_1, list);
        listview.setAdapter(adapter);

        listview.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> parent, final View view,
                                    int position, long id) {
                final String item = (String) parent.getItemAtPosition(position);
                view.animate().setDuration(2000).alpha(0)
                        .withEndAction(new Runnable() {
                            @Override
                            public void run() {
                                list.remove(item);
                                adapter.notifyDataSetChanged();
                                view.setAlpha(1);
                            }
                        });
            }

        });

    }

    private void addListenerOnButton() {

        RadioGroup radioLevelGroup;
        RadioButton radioLevelButton;

        radioLevelGroup = (RadioGroup) findViewById(R.id.service_choice);


        radioLevelGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {

            @Override


            public void onCheckedChanged(RadioGroup group, int checkedId) {

                // find which radio button is selected

                if (checkedId == R.id.radioSchool ){

                    displaySchoolHome();

                } else if (checkedId == R.id.radioClass) {

                    displayClasslHome();

                } else {

                }
            }
        });






    }
    private class StableArrayAdapter extends ArrayAdapter<String> {

        HashMap<String, Integer> mIdMap = new HashMap<String, Integer>();

        public StableArrayAdapter(Context context, int textViewResourceId,
                                  List<String> objects) {
            super(context, textViewResourceId, objects);
            for (int i = 0; i < objects.size(); ++i) {
                mIdMap.put(objects.get(i), i);
            }
        }

        @Override
        public long getItemId(int position) {
            String item = getItem(position);
            return mIdMap.get(item);
        }

        @Override
        public boolean hasStableIds() {
            return true;
        }

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

        // skip to 'Me' page
        Intent intent = new Intent(this, MeMainActivity.class);
        startActivity(intent);

    }
}
