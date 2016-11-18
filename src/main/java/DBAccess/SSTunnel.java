package main.java.DBAccess;
import com.jcraft.jsch.*;


public class SSTunnel {

    private String user;
    private String host;
    private String password;
    private int port;

    private JSch secureChannel;
    private Session session;

    public SSTunnel(String user, String host, String password, int port){
        this.user = user;
        this.host = host;
        this.password = password;

        this.port = port;
    }

    void initSession() throws JSchException {
        this.secureChannel = new JSch();
        this.session = this.secureChannel.getSession(this.user, this.host, this.port);

        session.setPassword(password);
        //If server's host key is unknown or changed, always insert new key
        session.setConfig("StrictHostKeyChecking", "no");
    }

    void forwardPort(int localPort, String distantHost, int distantPort){

        try {
            int assigned_port = this.session.setPortForwardingL(localPort, distantHost, distantPort);
        } catch (JSchException e) {
            e.printStackTrace();
        }
    }

}
