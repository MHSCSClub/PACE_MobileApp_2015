package com.aakportfolio.memorymoments;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;


public class ActivityChooser extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_activity_chooser);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_activity_chooser, menu);
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
    public void sendMessage(View view) {
        Intent intent = null;
        switch(view.getId()){
            case R.id.button5:
                //main menu
                intent = new Intent(this, MainActivity.class);
                break;
            case R.id.button6:
                //caregiver cal
                break;
            case R.id.button7:
                //patient cal
                break;
            case R.id.button8:
                //event care
                break;
            case R.id.button9:
                //flash list
                intent = new Intent(this, FlashcardsList.class);
                break;
            case R.id.button10:
                //flashcard view
                break;
            case R.id.button11:
                //add flash
                intent = new Intent(this, EditNewCard.class);
                break;
            case R.id.button12:
                //event patient
                intent = new Intent(this, PatientEvent.class);
                break;
            default:
                Toast.makeText(this, ""+view.getId(), Toast.LENGTH_SHORT).show();
        }
        if(intent != null) startActivity(intent);
        // Do something in response to button
    }
}
