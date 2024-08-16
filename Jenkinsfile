pipeline{
    agent any
    stages{
        // stage("A"){
        //     steps{
        //         echo "========executing A========"
        //     }
        //     post{
        //         always{
        //             echo "========always========"
        //         }
        //         success{
        //             echo "========A executed successfully========"
        //         }
        //         failure{
        //             echo "========A execution failed========"
        //         }
        //     }
        // }
        stage('Creating the infra'){
            steps {
                script  {
                    sh """
                    cd Terraform
                    terraform init
                    terraform plan
                    terraform apply -auto-approve
                    """
                }
            }
        }

        stage('Retrieve Public IP') {
            steps {
                script {
                    def publicIp = sh(script: 'cd Terraform; terraform output -raw public-ip', returnStdout: true).trim()
                    env.PUBLIC_IP = publicIp
                }
            }
        }

        stage('Update Ansible Inventory') {
            steps {
                script {
                    // Create the inventory file with the public IP
                    def inventoryContent = """
                    [slave]
                    config_server ansible_host=${env.PUBLIC_IP}

                    [slave:vars]
                    ansible_user=ubuntu
                    ansible_ssh_private_key_file=/Users/apple/code/tasks/my-key.pem
                    """
                    // Write the inventory file
                    writeFile file: 'Ansible/inventory.ini', text: inventoryContent
                }
            }
        }

        stage('running ansible configure script') {
            steps {
                sh """
                cd Ansible
                ansible-playbook -i inventory.ini ansible-playbook_configure.yml
                """ 
            }
        }
    }
    // post{
    //     always{
    //         echo "========always========"
    //     }
    //     success{
    //         echo "========pipeline executed successfully ========"
    //     }
    //     failure{
    //         echo "========pipeline execution failed========"
    //     }
    // }
}