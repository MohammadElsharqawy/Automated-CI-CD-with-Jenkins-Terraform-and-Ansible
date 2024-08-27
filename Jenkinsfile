pipeline {
    agent any
    
    parameters {
        choice(name: 'TERRAFORM_WORKSPACE', choices: ['dev', 'prod'], description: 'Choose Terraform workspace: dev or prod')
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select The Action To Perform')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID ')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/MohammadElsharqawy/Automated-CI-CD-with-Jenkins-Terraform-and-Ansible'
            }
        }
        
        stage('Terraform Init') {
            steps {
                dir('Inrastructure-by-Terraform') {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Check Workspace') {
            when {
                expression {
                    params.TERRAFORM_WORKSPACE != 'dev' && params.TERRAFORM_WORKSPACE != 'prod'
                }
            }
            steps {    
                error("Invalid Workspace, Please choose either 'dev' or 'prod'")
            }
        }
        
        stage('Create and Select Workspace') {
            steps {
                script {
                    def workspace = params.TERRAFORM_WORKSPACE
                    def workspaceExists = sh(script: "terraform workspace list | grep -q '${workspace}'", returnStatus: true) == 0
                   
                    if (!workspaceExists) {
                        echo "Workspace '${workspace}' doesn't exist. Creating..."
                        sh "terraform workspace new '${workspace}'"
                    }
                   
                    dir('Inrastructure-by-Terraform') {
                        sh "terraform workspace select '${params.TERRAFORM_WORKSPACE}'"
                    }
                }
            }
        }
        
        stage('Terraform Plan') {
            when {
                expression {
                    params.TERRAFORM_WORKSPACE == 'dev' || params.TERRAFORM_WORKSPACE == 'prod'
                }
            }
            steps {
                dir('Inrastructure-by-Terraform') {
                    sh "terraform plan -var-file=${params.TERRAFORM_WORKSPACE}.tfvars"
                }
            }
        }
        
        stage("Terraform Apply/Destroy") {
            when {
                expression {
                    params.TERRAFORM_WORKSPACE == 'dev' || params.TERRAFORM_WORKSPACE == 'prod'
                }
            }
            steps {
                script {
                    dir('Inrastructure-by-Terraform') {
                        if (params.ACTION == 'apply') {
                            sh "terraform apply -auto-approve -var-file=${params.TERRAFORM_WORKSPACE}.tfvars"
                        } else if (params.ACTION == 'destroy') {
                            sh "terraform destroy -auto-approve -var-file=${params.TERRAFORM_WORKSPACE}.tfvars"
                        } else {
                            error("Invalid action selected. Please choose either 'apply' or 'destroy'.")
                        }
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
