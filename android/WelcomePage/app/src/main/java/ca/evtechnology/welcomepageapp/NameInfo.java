package ca.evtechnology.welcomepageapp;

/**
 * Created by zhaofei on 2015-08-05.
 */
public class NameInfo {
    private String user_id;
    private String password;


    public NameInfo() {}

    public NameInfo(String email, String nickName) {
        this.user_id = email;
        this.password = nickName;
    }

    public String getEmail() {
        return user_id;
    }

    public void setEmail(String email) {
        this.user_id = email;
    }

    public String getNickName() {
        return password;
    }

    public void setNickName(String nickName) {
        this.password = nickName;
    }
}
