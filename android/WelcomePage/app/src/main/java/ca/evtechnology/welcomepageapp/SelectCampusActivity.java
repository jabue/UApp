package ca.evtechnology.welcomepageapp;

import android.app.Activity;
import android.app.ListActivity;
import android.app.SearchManager;
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
import android.widget.ListView;
import android.widget.SearchView;
import android.widget.SimpleCursorAdapter;


public class SelectCampusActivity extends ListActivity {

    private SearchView searchView;
    private ListView mListView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select_campus);

        // Get the SearchView and set the searchable configuration
        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        searchView = (SearchView) findViewById(R.id.searchView);

        // Assumes current activity is the searchable activity
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
        searchView.setIconifiedByDefault(false); // Do not iconify the widget; expand it by default

        // Get the intent, verify the action and get the query
        handleIntent(getIntent());
    }

    @Override
    protected void onNewIntent(Intent intent) {
        setIntent(intent);
        handleIntent(intent);
    }

    private void handleIntent(Intent intent) {
        if (Intent.ACTION_VIEW.equals(intent.getAction())) {
            // handles a click on a search suggestion; launches activity to show word
            Log.d("DEBUG", "ACTION_VIEW ");
            Intent homeIntent = new Intent(this, HomeActivity.class);
            homeIntent.setData(intent.getData());
            startActivity(homeIntent);
        } else if (Intent.ACTION_SEARCH.equals(intent.getAction())) {
            // handles a search query
            Log.d("DEBUG", "ACTION_SEARCH ");
            String query = intent.getStringExtra(SearchManager.QUERY);
            Log.d("DEBUG", "search " + query);
            showResults(query);
        }
    }

    /**
     * Searches the dictionary and displays results for the given query.
     * @param query The search query
     */
    private void showResults(String query) {
        Log.d("DEBUG", "I will show the result of query..." + query);
        Cursor cursor = managedQuery(DictionaryProvider.CONTENT_URI, null, null,
                new String[] {query}, null);

        if (cursor == null) {
            // There are no results
            searchView.setQueryHint(getString(R.string.no_results, new Object[]{query}));
        } else {
            // Display the number of results
            int count = cursor.getCount();
            String countString = getResources().getQuantityString(R.plurals.search_results,
                    count, new Object[] {count, query});
            searchView.setQueryHint(countString);

            // Specify the columns we want to display in the result
            String[] from = new String[] { DictionaryDatabase.KEY_WORD,
                    DictionaryDatabase.KEY_DEFINITION };

            // Specify the corresponding layout elements where we want the columns to go
            int[] to = new int[] { R.id.word,
                    R.id.definition };

            // Create a simple cursor adapter for the definitions and apply them to the ListView
            SimpleCursorAdapter words = new SimpleCursorAdapter(this,
                    R.layout.result, cursor, from, to);
            mListView.setAdapter(words);

            // Define the on-click listener for the list items
            mListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                    // Build the Intent used to open WordActivity with a specific word Uri
                    Intent wordIntent = new Intent(getApplicationContext(), schoolActivity.class);
                    Uri data = Uri.withAppendedPath(DictionaryProvider.CONTENT_URI,
                            String.valueOf(id));
                    wordIntent.setData(data);
                    startActivity(wordIntent);
                }
            });
        }
    }

        @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_select_campus, menu);
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
