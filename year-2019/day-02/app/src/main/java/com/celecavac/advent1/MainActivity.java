package com.celecavac.advent1;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private TextView textView1;
    private TextView textView2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textView1 = (TextView) findViewById(R.id.textView1);
        textView2 = (TextView) findViewById(R.id.textView2);

        Executer executer = new Executer(Inputs.input1,12, 2);
        executer.run();
        textView1.setText(executer.getResult());

        OutputFinder outputFinder = new OutputFinder(Inputs.input1, Inputs.input2);
        outputFinder.find();
        textView2.setText(outputFinder.getResult());
    }
}
