package main.java.DBAccess;
import com.jcraft.jsch.*;


public class SSTunnel {

    private String user;
    private String host;
    private String password;
    private int port;

    private JSch secureChannel;
    private Session session;

    private int portForwarding = -1;

    public SSTunnel(String user, String host, String password, int port){
        this.user = user;
        this.host = host;
        this.password = password;

        this.port = port;
    }

    public void initSession() throws JSchException {
        this.secureChannel = new JSch();
        this.session = this.secureChannel.getSession(this.user, this.host, this.port);

        session.setPassword(this.password);
        //If server's host key is unknown or changed, always insert new key
        session.setConfig("StrictHostKeyChecking", "no");
        this.session.connect();
    }

    void forwardPort(int localPort, String distantHost, int distantPort){

        try {
            this.portForwarding = this.session.setPortForwardingL(localPort, distantHost, distantPort);
        } catch (JSchException e) {
            e.printStackTrace();
        }
    }

    public void close() throws JSchException {
        if(this.portForwarding != -1) this.session.delPortForwardingL(this.portForwarding);
        this.session.disconnect();
    }

    public boolean isOpen(){
        return this.session.isConnected();
    }

    public String getHost(){
        return this.host;
    }
}
