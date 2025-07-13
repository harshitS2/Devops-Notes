## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Pipeline Projects Overview](#pipeline-projects-overview)
4. [Creating a Declarative Pipeline](#creating-a-declarative-pipeline)
5. [Configuring Jenkins Master and Slave Nodes](#configuring-jenkins-master-and-slave-nodes)
6. [Setting Up a Tomcat Server](#setting-up-a-tomcat-server)
7. [Deployment Process](#deployment-process)
8. [Additional Notes](#additional-notes)
9. [Next Steps](#next-steps)
10. [Resources and Recommendations](#resources-and-recommendations)

---

## Introduction

The session is a hands-on training on Jenkins pipeline projects, focusing on creating declarative pipelines, configuring master and slave nodes, and integrating a Tomcat server for application deployments. The instructor emphasizes practical application in a DevOps context, urging participants to follow class notes, avoid simultaneous practice during the session, and refer to documentation for clarity.

- **Objective**: Teach participants how to create and execute Jenkins pipeline projects, configure distributed architectures (master/slave nodes), and deploy artifacts to a Tomcat server.
- **Target Audience**: DevOps learners with prior Linux, AWS, and basic Jenkins knowledge.
- **Session Date and Time**: July 13, 2025, 01:30 PM IST.
- **Instructor Guidance**: Participants should ask questions during the session, practice offline using class notes, and bookmark the shared repository for reference.

---

## Prerequisites

### Linux Knowledge
- **Package Management**: Familiarity with Linux commands (`apt`, `useradd`, `chmod`, `chown`, `tar`, `wget`) for installing tools and managing users.
- **SSH Configuration**: Understanding of SSH key generation (`ssh-keygen`), authorized keys, and file permissions.
- **File System**: Knowledge of Linux directories (e.g., `/opt`, `/etc`) and their purposes.

### AWS Knowledge
- **EC2 Management**: Ability to launch, configure, and manage EC2 instances (e.g., Ubuntu 22.04, `t2.micro`).
- **Security Groups**: Configure inbound rules to enable ports (e.g., 8080 for Jenkins, 8080 for Tomcat).
- **Billing Awareness**: Monitor AWS free tier usage to avoid charges.

### Jenkins Knowledge
- **Freestyle Projects**: Basic understanding of freestyle projects (from previous sessions).
- **Plugins**: Familiarity with installing plugins (e.g., `Publish Over SSH`).

### Class Notes
- **Repository**: The instructor shared a repository with detailed notes and installation steps. Fork or bookmark it for reference, as it may be unavailable after the instructor’s availability ends (tomorrow).
- **Recommendation**: Save a local copy of the notes and review them before each session.

---

## Pipeline Projects Overview

### Types of Pipeline Projects
- **Scripted Pipelines**:
  - Based on Groovy scripting, used in early Jenkins versions.
  - Requires expertise in Groovy, making it less user-friendly.
  - Not used in modern projects; mentioned for historical context.
- **Declarative Pipelines**:
  - Simplified, user-friendly approach introduced to make Jenkins accessible.
  - Uses a structured syntax with keywords like `pipeline`, `stages`, `agent`, and `steps`.
  - Supports auto-generated scripts via the **Snippet Generator**.
  - Preferred for all upcoming projects due to its intuitive nature and compatibility with tools like Azure Pipelines, GitLab CI, and AWS CodePipeline (which use YAML).

### Why Declarative Pipelines?
- **Ease of Use**: No need for deep Groovy knowledge; scripts can be generated automatically.
- **Competition**: Aligns with industry-standard tools (e.g., YAML-based pipelines in GitLab CI).
- **Flexibility**: Allows defining multiple stages (e.g., SCM checkout, build, deploy) with clear structure.

---

## Creating a Declarative Pipeline

### Steps to Create a Pipeline
1. **Access Dashboard**:
   - Navigate to the Jenkins dashboard (`<public-ip>:8080`).
   - Click `New Item`.
2. **Project Setup**:
   - Enter a unique project name (e.g., `MyPipeline`).
   - Select `Pipeline` as the template.
   - Click `OK` to open the configuration page.
3. **Configuration**:
   - **General**: Add a description or enable parameterization (e.g., for environment variables).
   - **Build Triggers**: Configure automated triggers (e.g., periodic builds, GitHub webhooks; to be covered in the next session).
   - **Pipeline**:
     - Define the pipeline script manually or use the **Snippet Generator**.
     - Sample pipelines are available under `Try Sample Pipelines` for reference.
4. **Pipeline Structure**:
   - Starts with the `pipeline` keyword.
   - Includes an `agent` parameter to specify the execution node (e.g., `any` for any available node, `master` for the master node, or a specific slave node).
   - Contains `stages` block with multiple `stage` definitions, each with a name and `steps` (tasks to execute).
5. **Save and Build**:
   - Click `Apply` to save without closing or `Save` to save and exit.
   - Go to the project dashboard and click `Build Now` to execute the pipeline.

### Example Pipeline Script
```groovy
pipeline {
    agent any
    stages {
        stage('SCM Checkout') {
            steps {
                echo 'Performing SCM Checkout'
            }
        }
        stage('Application Build') {
            steps {
                echo 'Building Application'
            }
        }
        stage('Deploy to Target Server') {
            steps {
                echo 'Deploying to Target Server'
            }
        }
    }
}
```
- **Explanation**:
  - `agent any`: Executes the pipeline on any available node (master or slave).
  - `stages`: Defines three stages: SCM Checkout, Application Build, and Deploy to Target Server.
  - `steps`: Each stage prints a message (placeholder for actual tasks like Git checkout or Maven build).
- **Execution**:
  - After saving, click `Build Now` to run the pipeline.
  - View the **Stage View** to see the status of each stage (e.g., execution time, success/failure).
  - Check **Console Output** for detailed logs.

### Snippet Generator
- **Purpose**: Auto-generates pipeline script snippets for tasks (e.g., Git checkout, Maven build).
- **Access**: In the pipeline configuration page, click `Pipeline Syntax` > `Snippet Generator`.
- **Example**:
  - Select `git` step, enter the repository URL, and generate the script.
  - Copy the generated script into the pipeline definition.

### Key Notes
- **Syntax**: Use correct syntax (e.g., curly braces `{}`) to avoid errors.
- **Stage View**: Visualizes pipeline stages, showing execution time and status.
- **Practice**: Avoid practicing during the session to stay focused; use class notes for offline practice.

---

## Configuring Jenkins Master and Slave Nodes

### Overview
- **Master Node**: Controls job scheduling and interfaces with slave nodes and target servers.
- **Slave Node**: Executes build tasks (e.g., compiling code, running tests) to offload work from the master.
- **Purpose**: Distribute workload for scalability and efficiency in CI/CD pipelines.

### Steps to Configure a Slave Node
1. **Launch Slave Node**:
   - Create an AWS EC2 instance (Ubuntu 22.04, `t2.micro`).
   - Tag it (e.g., `Jenkins-Slave-Node-1`).
   - Enable port 22 (SSH) in the security group.
2. **Install Build Tools**:
   - Update packages: `sudo apt update`.
   - Install Java (JDK 17): `sudo apt install openjdk-17-jdk`.
   - Install Git: `sudo apt install git` (usually pre-installed; verify with `git --version`).
   - Install Maven: `sudo apt install maven` (verify with `mvn --version`).
3. **Create User**:
   - Add a user (e.g., `devops`): `sudo useradd -m -s /bin/bash devops`.
   - Switch to the user: `su - devops`.
4. **Set Up SSH Keys**:
   - Generate SSH key pair: `ssh-keygen -t rsa` (press Enter for defaults).
   - Navigate to `~/.ssh` and verify `id_rsa` (private key) and `id_rsa.pub` (public key).
   - Create `authorized_keys`: `cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys`.
   - Secure keys: `chmod 600 ~/.ssh/authorized_keys` and `chmod 700 ~/.ssh`.
5. **Integrate with Master**:
   - Go to `Manage Jenkins > Nodes and Clouds > New Node`.
   - Enter a node name (e.g., `Slave-Node-1`).
   - Configure:
     - **Remote Root Directory**: Home directory of the user (e.g., `/home/devops`).
     - **Host**: Public IP of the slave node.
     - **Credentials**: Add SSH private key (`id_rsa`) for the `devops` user.
     - **Launch Method**: Select `Launch agent via SSH`.
   - Save and verify the node status in `Nodes and Clouds`.

### Example: Building a Java Application
- **Repository**: Use the provided Maven project repository link.
- **Pipeline Script**:
  ```groovy
  pipeline {
      agent { label 'Slave-Node-1' }
      stages {
          stage('SCM Checkout') {
              steps {
                  git 'https://<repository-url>'
              }
          }
          stage('Application Build') {
              steps {
                  sh 'mvn clean install'
              }
          }
      }
  }
  ```
- **Explanation**:
  - `agent { label 'Slave-Node-1' }`: Runs the pipeline on the specified slave node.
  - `git`: Checks out the source code from the repository.
  - `mvn clean install`: Builds the Java application, creating a WAR file in the `target` folder.
- **Output**:
  - Artifacts (e.g., `demo-1.0-SNAPSHOT.war`) are stored in `/home/devops/workspace/<project-name>/target`.
  - View build status in **Stage View** and logs in **Console Output**.

---

## Setting Up a Tomcat Server

### Overview
- **Purpose**: Deploy Java-based web applications (WAR files) to a Tomcat server.
- **Tomcat**: A web application server running on port 8080 by default.

### Steps to Set Up Tomcat
1. **Launch VM**:
   - Create an AWS EC2 instance (Ubuntu 22.04, `t2.micro`).
   - Tag it (e.g., `Tomcat-Server`).
   - Enable ports 22 (SSH) and 8080 (Tomcat) in the security group.
2. **Install JDK**:
   - Update packages: `sudo apt update`.
   - Install JDK: `sudo apt install openjdk-17-jdk`.
3. **Install Tomcat**:
   - Navigate to `/opt`: `cd /opt`.
   - Download Tomcat binary: `sudo wget <tomcat-url>` (e.g., from the official Tomcat website).
   - Extract: `sudo tar -xvzf <tomcat-file>.tar.gz`.
   - Rename folder: `sudo mv apache-tomcat-<version> tomcat`.
   - Start Tomcat: `sudo /opt/tomcat/bin/startup.sh`.
   - Verify: Access `<public-ip>:8080` in a browser to see the Tomcat welcome page.
4. **Create User**:
   - Add user: `sudo useradd -m -s /bin/bash devops`.
   - Switch to user: `su - devops`.
   - Generate SSH keys: `ssh-keygen -t rsa`.
   - Create `authorized_keys`: `cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys`.
   - Secure keys: `chmod 600 ~/.ssh/authorized_keys` and `chmod 700 ~/.ssh`.
5. **Grant Permissions**:
   - Change ownership of Tomcat directory: `sudo chown -R devops:devops /opt/tomcat`.
   - Verify access: As `devops` user, navigate to `/opt/tomcat/webapps` (where WAR files are deployed).

### Key Notes
- **Port Conflict**: Ensure Jenkins and Tomcat run on separate VMs to avoid port 8080 conflicts.
- **Webapps Folder**: WAR files must be placed in `/opt/tomcat/webapps` for Tomcat to recognize them.
- **Documentation**: Refer to the official Tomcat website for the latest binary URLs and installation steps.

---

## Deployment Process

### Overview
- **Definition**: Deployment involves copying artifacts (e.g., WAR files) from the source server (slave node) to the target server (Tomcat server).
- **Tool**: Use the `Publish Over SSH` plugin to transfer artifacts via SSH.

### Steps to Deploy
1. **Install Publish Over SSH Plugin**:
   - Go to `Manage Jenkins > Plugins > Available Plugins`.
   - Search for `Publish Over SSH` and install with the restart option.
2. **Configure SSH Server**:
   - Go to `Manage Jenkins > System Configuration`.
   - Add SSH server details:
     - **Host**: Public IP of the Tomcat server.
     - **Username**: `devops`.
     - **Key**: Private key (`id_rsa`) of the `devops` user.
3. **Update Pipeline**:
   - Add a deployment stage to the pipeline script:
     ```groovy
     stage('Deploy to Target Server') {
         steps {
             sshPublisher(
                 publishers: [
                     sshPublisherDesc(
                         configName: 'Tomcat-Server',
                         transfers: [
                             sshTransfer(
                                 sourceFiles: 'target/*.war',
                                 remoteDirectory: '/opt/tomcat/webapps'
                             )
                         ]
                     )
                 ]
             )
         }
     }
     ```
   - **Explanation**:
     - `sshPublisher`: Uses the `Publish Over SSH` plugin.
     - `configName`: References the configured SSH server (e.g., `Tomcat-Server`).
     - `sourceFiles`: Specifies the WAR file path (e.g., `target/*.war`).
     - `remoteDirectory`: Specifies the target path (`/opt/tomcat/webapps`).
4. **Execute Pipeline**:
   - Click `Build Now` to run the pipeline.
   - Verify the WAR file is copied to `/opt/tomcat/webapps` on the Tomcat server.
   - Access the application via `<tomcat-public-ip>:8080/<war-file-name>`.

### Key Notes
- **Source Server**: Slave node (`/home/devops/workspace/<project-name>/target`).
- **Target Server**: Tomcat server (`/opt/tomcat/webapps`).
- **Permissions**: Ensure the `devops` user has write access to `/opt/tomcat/webapps`.
- **Plugin Requirement**: The `Publish Over SSH` plugin requires a Jenkins restart after installation.

---

## Additional Notes

### Instructor Guidance
- **Active Participation**: Ask questions in the chat or Q&A section during the session, not after, for immediate clarification.
- **Offline Practice**: Practice using class notes and recordings after the session to reinforce learning.
- **Documentation**: Follow the provided documentation step-by-step to avoid errors (e.g., use Ubuntu 22.04, install specific tools).

### Real-World Context
- **CI/CD Workflow**: The session covers a complete CI/CD pipeline: SCM checkout, build, and deployment.
- **Scalability**: Master/slave architecture supports distributed builds, essential for large-scale projects.
- **Tomcat**: Commonly used for Java-based web applications; other servers (e.g., NGINX, Apache) may be used for different applications.

### Challenges
- **Network Issues**: The session faced network disruptions, affecting clarity. Refer to class notes for missed details.
- **Permissions**: Ensure proper ownership (`chown`) for directories like `/opt/tomcat/webapps` to avoid access issues.
- **Learning Curve**: Pipelines may seem complex initially but become straightforward with practice.

---

## Next Steps

### Upcoming Topics
- **Deployment Completion**: Integrate the Tomcat server with Jenkins using the `Publish Over SSH` plugin to complete the deployment stage.
- **Build Triggers**: Configure GitHub webhooks and periodic build triggers.
- **Email Notifications**: Set up notifications for build status updates.
- **Docker Integration**: Explore using Docker containers instead of VMs for builds (next module).

### Action Items
1. **Practice Pipeline Creation**:
   - Create a declarative pipeline with SCM checkout and build stages.
   - Test the pipeline on the master node and verify the stage view.
2. **Set Up Slave Node**:
   - Launch an Ubuntu 22.04 VM, install JDK, Git, and Maven, and configure SSH keys.
   - Integrate the slave node with the Jenkins master.
3. **Set Up Tomcat Server**:
   - Launch a VM, install JDK and Tomcat, and configure the `devops` user.
   - Verify Tomcat access via `<public-ip>:8080`.
4. **Install Plugin**:
   - Install the `Publish Over SSH` plugin in Jenkins and restart the server.
5. **Review Notes**:
   - Go through the shared repository and installation documentation before the next session.
   - Bookmark the repository link for future reference.

---

## Resources and Recommendations

### Resources
- **Jenkins Documentation**: [Official Jenkins Website](https://www.jenkins.io/doc/) for pipeline syntax, plugin details, and tutorials.
- **Tomcat Documentation**: [Apache Tomcat Website](https://tomcat.apache.org/) for binary downloads and setup guides.
- **AWS Documentation**: [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/) for instance management and security group configuration.
- **Class Notes Repository**: Bookmark the shared repository link (to be provided by the instructor).

### Recommendations
- **Regular Practice**: Dedicate time to practice pipeline creation, node configuration, and Tomcat setup.
- **Documentation Review**: Study class notes and recordings before sessions to clarify concepts.
- **Community Support**: Engage with Jenkins or DevOps communities (e.g., Stack Overflow, Jenkins Community) for additional help.
- **AWS Monitoring**: Regularly check the AWS billing dashboard to stay within free tier limits.
- **Backup Notes**: Save all shared resources locally to ensure access after the instructor’s availability ends (tomorrow).

---
