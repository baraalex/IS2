package es.upm.etsiinf.is2.grupo11;

/**
 * Created by DaCoNDe on 11/11/2014.
 */
public class Usuario {
    private String login;
    private String password;

    private boolean authenticated = false;

    /**
     * @return the login
     */
    public String getLogin() {
        return login;
    }

    /**
     * @param login the login to set
     */
    public void setLogin(String login) {
        this.login = login;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    protected boolean isCorrect() {
        return (this.login.equals("demo") && this.password.equals("demo"));
    }

    /**
     * @return 'success' or 'fail' according to auth parameters
     */
    public String Authenticate() {
        if (isCorrect()) {
            this.authenticated = true;
            return "success";
        } else {
            return "fail";
        }
    }

    public void Logout() {
        this.authenticated = false;
    }

    /**
     * @return the authenticated
     */
    public Boolean getAuthenticated() {
        return authenticated;
    }
}
