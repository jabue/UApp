package ca.evtechnology.welcomepageapp;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.GestureDetector;
import android.view.GestureDetector.OnGestureListener;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.ToggleButton;
import android.widget.ViewFlipper;


public class MainActivity extends ActionBarActivity {

        private ViewFlipper mViewFlipper;
        private GestureDetector mGestureDetector;

        int[] resources = {
                R.drawable.test1,
                R.drawable.test2,
                R.drawable.test3
        };

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            // Get the ViewFlipper
            mViewFlipper = (ViewFlipper) findViewById(R.id.viewFlipper);

            // Add all the images to the ViewFlipper
            for (int i = 0; i < resources.length; i++) {
                ImageView imageView = new ImageView(this);
                imageView.setImageResource(resources[i]);
                mViewFlipper.addView(imageView);
            }

            // Set in/out flipping animations
            mViewFlipper.setInAnimation(this, android.R.anim.fade_in);
            mViewFlipper.setOutAnimation(this, android.R.anim.fade_out);

            CustomGestureDetector customGestureDetector = new CustomGestureDetector();
            mGestureDetector = new GestureDetector(this, customGestureDetector);
        }

        class CustomGestureDetector extends GestureDetector.SimpleOnGestureListener {
            @Override
            public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {

                int indexOfPic = mViewFlipper.getDisplayedChild();
                RadioButton myButton = null;
                Log.i("TAG", " is " + mViewFlipper.getDisplayedChild());

                // Swipe left (next), stop when come to the last one
                if (e1.getX() > e2.getX()) {

                    switch (indexOfPic)
                    {
                        case 0:
                            mViewFlipper.showNext();
                            myButton = (RadioButton) findViewById(R.id.radioButton1);
                            myButton.setChecked(true);
                            break;
                        case 1:
                            mViewFlipper.showNext();
                            myButton = (RadioButton) findViewById(R.id.radioButton2);
                            myButton.setChecked(true);
                            break;
                        case 2:
                            // end of welcome page. skip to register page
                            Log.i("todo:", "skip to register page..");
                            break;
                        default:
                            break;
                    }
                }

                // Swipe right (previous)  stop when come to the first one
                if (e1.getX() < e2.getX() ){
                    switch (indexOfPic)
                    {
                        case 0:
                            break;
                        case 1:
                            mViewFlipper.showPrevious();
                            myButton = (RadioButton) findViewById(R.id.radioButton0);
                            myButton.setChecked(true);
                            break;
                        case 2:
                            mViewFlipper.showPrevious();
                            myButton = (RadioButton) findViewById(R.id.radioButton1);
                            myButton.setChecked(true);
                            break;
                        default:
                            break;
                    }
                }
                return super.onFling(e1, e2, velocityX, velocityY);
            }
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            mGestureDetector.onTouchEvent(event);

            return super.onTouchEvent(event);
        }

        @Override
        public boolean onCreateOptionsMenu(Menu menu) {
            // Inflate the menu; this adds items to the action bar if it is present.
            getMenuInflater().inflate(R.menu.menu_main, menu);
            return true;
        }

        @Override
        public boolean onOptionsItemSelected(MenuItem item) {
            // Handle action bar item clicks here. The action bar will
            // automatically handle clicks on the Home/Up button, so long
            // as you specify a parent activity in AndroidManifest.xml.
            int id = item.getItemId();
            if (id == R.id.action_settings) {
                return true;
            }
            return super.onOptionsItemSelected(item);
        }

    public void onRadioButtonClicked(View view){
        // Is the button now checked?
        boolean checked = ((RadioButton) view).isChecked();

        // Check which radio button was clicked
        switch(view.getId()) {
            case R.id.radioButton0:
                if (checked)
                    //
                    mViewFlipper.setDisplayedChild(0);
                    break;
            case R.id.radioButton1:
                if (checked)
                    mViewFlipper.setDisplayedChild(1);
                    break;
            case R.id.radioButton2:
                if (checked)
                    mViewFlipper.setDisplayedChild(2);
                    break;
        }
    }

    public void onButtonClicked(View view){
        Intent intent = new Intent(this, SelectCampusActivity.class);

        startActivity(intent);
    }
}