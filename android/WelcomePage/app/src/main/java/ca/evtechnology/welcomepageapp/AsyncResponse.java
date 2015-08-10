package ca.evtechnology.welcomepageapp;

/**
 * Created by zhaofei on 2015-08-09.
 */
public interface AsyncResponse<T> {
    public void onSuccess(T object);
    public void onFailure(Exception e);
}
