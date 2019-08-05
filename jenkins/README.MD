#Installing Jenkins server

## Install Java
'''console
sudo apt-get install default-jre
'''
####First, we'll add the repository key to the system.

'''console
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -

####When the key is added, the system will return OK. Next, we'll append the Debian package repository address to the server's sources.list:

'''console
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

####When both of these are in place, we'll run update so that apt-get will use the new repository:

'''console
sudo apt-get update
'''

####Finally, we'll install Jenkins and its dependencies, including Java:

'''console
sudo apt-get install jenkins
'''
Now that Jenkins and its dependencies are in place, we'll start the Jenkins server.

Using systemctl we'll start Jenkins:

'''console
sudo systemctl start jenkins
'''

Since systemctl doesn't display output, we'll use its status command to verify that it started successfully:

'''console
sudo systemctl status jenkins


'''


###Create Firewall Rule to Allow Jenkins Traffic

Allow traffic from all soruce to tcp port 8080


gcloud compute firewall-rules create jenkins \
      --allow tcp:8080 \
    --description "Allow incoming traffic on TCP port 8080 for jenkins"



