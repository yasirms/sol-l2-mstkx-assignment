# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk


#initialize the gcloud
gcloud init

# You will get a prompt to login to the gcloud. Now login to the gcloud 

#To continue, you must log in. Would you like to log in (Y/n)? Y

# At the next promt select eh project name 

#Pick cloud project to use:
 #[1] [mstakx]
 #[2] [test-project]
 #...
 #Please enter your numeric choice:


 # Next select the default compute zone of the project

 #[1] [us-east1-a]
 #[2] [us-east1-b]
 #...
 #[14] Do not use default zone
 #Please enter your numeric choice:

 #You will get a confirmation like below at the end of execution that all steps have been completed successfully

#gcloud has now been configured!
#You can use [gcloud config] to change more gcloud settings.

#Your active configuration is: [default]

