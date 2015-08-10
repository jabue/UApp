package ca.evtechnology.welcomepageapp;

/**
 * Created by zhaofei on 2015-08-09.
 */
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;

import com.amazonaws.auth.CognitoCachingCredentialsProvider;
import com.amazonaws.mobileconnectors.lambdainvoker.LambdaFunctionException;
import com.amazonaws.mobileconnectors.lambdainvoker.LambdaInvokerFactory;
import com.amazonaws.regions.Regions;

/**
 * Created by cesarferreira on 22/05/14.
 */
public class CheckUseridAsyncTask extends AsyncTask<NameInfo, Void, String> {

    private AsyncResponse<String> mCallBack;
    private Context mContext;
    public Exception mException;
    public  NameInfo mNameInfo;



    public CheckUseridAsyncTask(Context context, NameInfo nameInfo, AsyncResponse callback) {
        mCallBack = callback;
        mContext = context;
        mNameInfo = nameInfo;

    }

    @Override
    protected String doInBackground(NameInfo... params) {

        try {
            // todo try to do something dangerous
            CognitoCachingCredentialsProvider cognitoProvider = new CognitoCachingCredentialsProvider(
                    mContext.getApplicationContext(), "us-east-1:cab334cf-8514-4060-82e7-13afbdd331f5", Regions.US_EAST_1);

            // Create LambdaInvokerFactory, to be used to instantiate the Lambda proxy.
            LambdaInvokerFactory factory = new LambdaInvokerFactory(mContext.getApplicationContext(),
                    Regions.US_EAST_1, cognitoProvider);
            Log.d("MeMainActivity", "create LambadInvokerFactroy successfully.");
            // Create the Lambda proxy object with a default Json data binder.
            // You can provide your own data binder by implementing
            // LambdaDataBinder.
            final MyInterface myInterface = factory.build(MyInterface.class);
            return myInterface.queryDB(mNameInfo);
            } catch ( LambdaFunctionException lfe){
                Log.e("CheckUseridAsyncTask", "Failed to invoke " , lfe);
                return  null;
            }

    }

    @Override
    protected void onPostExecute(String result) {
        if (mCallBack != null) {
            if (mException == null) {
                mCallBack.onSuccess(result);
            } else {
                mCallBack.onFailure(mException);
            }
        }
    }
}
