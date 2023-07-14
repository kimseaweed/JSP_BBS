package user;

public class User {
private String userID;
public String getUserID() {
	return userID;
}
public void setUserID(String userID) {
	this.userID = userID;
}
public String getUserPassword() {
	return userPassword;
}
@Override
public String toString() {
	System.out.println("User [userID=" + userID + ", userPassword=" + userPassword + ", userName=" + userName + ", userGender="
			+ userGender + ", userEmail=" + userEmail + "]");
	return "User [userID=" + userID + ", userPassword=" + userPassword + ", userName=" + userName + ", userGender="
			+ userGender + ", userEmail=" + userEmail + "]";
	
}
public void setUserPassword(String userPassword) {
	this.userPassword = userPassword;
}
public String getUserName() {
	return userName;
}
public void setUserName(String userName) {
	this.userName = userName;
}
public String getUserGender() {
	return userGender;
}
public void setUserGender(String userGender) {
	this.userGender = userGender;
}
public String getUserEmail() {
	return userEmail;
}
public void setUserEmail(String userEmail) {
	this.userEmail = userEmail;
}
private String userPassword;
private String userName;
private String userGender;
private String userEmail;
}
