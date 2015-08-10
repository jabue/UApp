package ca.evtechnology.welcomepageapp;

/**
 * Created by zhaofei on 2015-08-05.
 */
import com.amazonaws.mobileconnectors.lambdainvoker.LambdaFunction;
public interface MyInterface {

    /**
     * Invoke the Lambda function "ExampleAndroidEventProcessor".
     * The function name is the method name.
     */
    @LambdaFunction
    String simpleWriteDynamoDB(NameInfo nameInfo);

    @LambdaFunction
    String queryDB(NameInfo nameInfo);

}


