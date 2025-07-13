
---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites and Setup](#prerequisites-and-setup)
3. [Jenkins Installation and Post-Installation](#jenkins-installation-and-post-installation)
4. [AWS Instance Management](#aws-instance-management)
5. [Jenkins Dashboard Overview](#jenkins-dashboard-overview)
6. [Global System Configuration](#global-system-configuration)
7. [Plugins Management](#plugins-management)
8. [Creating Freestyle Projects](#creating-freestyle-projects)
9. [Variables in Jenkins](#variables-in-jenkins)
10. [Troubleshooting and Console Output](#troubleshooting-and-console-output)
11. [Additional Notes](#additional-notes)
12. [Next Steps](#next-steps)
13. [Resources and Recommendations](#resources-and-recommendations)

---

## Introduction

The session is a hands-on training on Jenkins, a widely-used open-source automation server for Continuous Integration and Continuous Deployment (CI/CD). The instructor emphasizes practical understanding and application, urging participants to follow class notes, avoid blind replication, and practice independently. The session covers Jenkins setup, administration, project creation, and variable management, with a focus on real-world DevOps scenarios.

Key points:
- **Objective**: Equip participants with the skills to install, configure, and administer Jenkins, create projects, and troubleshoot issues.
- **Target Audience**: DevOps learners with prior Linux and AWS knowledge.
- **Session Date**: July 13, 2025, 01:24 PM IST.
- **Instructor Guidance**: Participants are encouraged to ask questions during the session, refer to provided documentation, and practice offline using class notes.

---

## Prerequisites and Setup

### Linux Knowledge
- **Package Management**: Familiarity with Linux package managers is essential:
  - **APT** (Advanced Package Tool) for Ubuntu-based systems.
  - **YUM** or **DNF** for CentOS/RHEL-based systems.
  - Participants should revisit Linux module notes for package management commands and concepts.
- **Shell Scripting**: Basic understanding of shell scripting (e.g., `echo`, file creation) is required for creating build steps in Jenkins projects.

### AWS Knowledge
- **Instance Management**: Understanding of AWS EC2 instances, including launching, stopping, and terminating instances.
- **Free Tier Usage**: Awareness of AWS free tier limits (e.g., 30 GB volume) and billing dashboard monitoring to avoid charges.
- **Recommended Instance**: Use Ubuntu 22.04 with `t2.micro` instance type for Jenkins installation.

### Class Notes
- The instructor has shared detailed class notes and installation steps in a repository.
- **Action**: Fork or bookmark the repository URL to retain access, as the instructor will only be available for two more days.
- **Recommendation**: Save a local copy of the notes to ensure access even if the repository is deleted.

---

## Jenkins Installation and Post-Installation

### Installation
- **Default Port**: Jenkins runs on port `8080` by default. Ensure this port is enabled in your VM’s security group to access the Jenkins dashboard.
- **Single Instance**: Only one Jenkins instance is required per VM. Avoid creating multiple instances unless necessary for specific use cases.
- **Steps**:
  1. Launch an AWS EC2 instance (Ubuntu 22.04, `t2.micro`).
  2. Install Jenkins and its prerequisites (e.g., Java) using the appropriate package manager (APT for Ubuntu).
  3. Access Jenkins via `<public-ip>:8080` in a web browser.
- **Persistence**: Once installed, Jenkins does not need to be reinstalled unless the VM is terminated. Stop the instance when not in use to avoid AWS charges.

### Post-Installation
- **Default Plugins**: Install all suggested plugins during the initial setup to enable core functionalities.
- **Access**: Use the public IP and port `8080` to access the Jenkins dashboard. No need to execute installation commands repeatedly.
- **Warning**: Deleting the VM requires reinstalling Jenkins from scratch, so avoid termination unless necessary.

---

## AWS Instance Management

### Best Practices
- **Stop vs. Terminate**:
  - **Stop**: Halts the instance without deleting it, preserving installed software (e.g., Jenkins). No charges are incurred when stopped (within free tier limits).
  - **Terminate**: Deletes the instance, requiring a fresh setup. Avoid unless the instance is no longer needed.
- **Billing Monitoring**:
  - Regularly check the AWS billing dashboard to monitor free tier usage (e.g., 30 GB volume limit).
  - Exceeding free tier limits incurs charges, so manage resources carefully.
- **Instance Management**:
  - Use the AWS EC2 dashboard to start, stop, or monitor instances.
  - Example: The instructor demonstrated starting an instance created in a previous session and stopping it when not in use.

### Recommendations
- Always stop instances when not in use to avoid costs.
- Document instance details (e.g., public IP, instance ID) for easy reference.

---

## Jenkins Dashboard Overview

### Key Features
- **New Item**: Used to create new Jenkins projects (e.g., freestyle or pipeline projects).
- **Build History**: Displays the status of executed jobs (success or failure).
- **Build Executor Status**: Shows the number of parallel jobs Jenkins can execute (default: 2 executors).
  - Example: Increasing executors to 5 allows 5 simultaneous jobs. Additional jobs are queued in the build queue.
- **Manage Jenkins**: Central hub for administrative tasks, including:
  - Global system configuration
  - Plugins management
  - Tools management
  - User management
  - Security and credentials

### Accessing the Dashboard
- Navigate to `<public-ip>:8080` in a web browser.
- Explore the user interface to understand available options before performing administrative tasks.

---

## Global System Configuration

### Purpose
- **Default Properties**: Set default settings for Jenkins, such as the number of executors or server labels.
- **Remote Server Configuration**: Integrate Jenkins with remote servers (e.g., GitHub repositories, email servers, Kubernetes clusters).

### Configuration Steps
1. **Access**: Go to `Manage Jenkins > System Configuration` (or `Configure Global Settings`).
2. **Settings**:
   - **Number of Executors**: Default is 2; can be increased (e.g., to 5) to allow more parallel jobs.
   - **Home Directory**: Displays the Jenkins home directory (e.g., `~/.jenkins`).
   - **Remote Servers**: Configure connections to external systems (e.g., GitHub, Kubernetes, email servers).
3. **Apply Changes**: Click `Apply` to save without closing or `Save` to save and exit.

### Examples
- **Executor Adjustment**: Changing executors from 2 to 5 allows 5 parallel jobs. Excess jobs wait in the build queue.
- **Remote Server Setup**: Configure GitHub repositories or email servers for notifications (covered in future sessions).
- **Use Case**: For CI/CD pipelines, remote server configurations enable automated deployments to QA, UAT, or production environments.

### Key Notes
- Global system configuration is critical for defining Jenkins’ operational parameters.
- Changes (e.g., executor count) are reflected immediately in the dashboard (e.g., build executor status updates).

---

## Plugins Management

### Overview
- Plugins extend Jenkins’ functionality for tasks like building, testing, and deploying applications.
- Managed via `Manage Jenkins > Plugins`.

### Key Tabs
1. **Installed Plugins**:
   - Lists all plugins currently installed.
   - Options: Enable, disable, or uninstall plugins.
   - Example: Default plugins installed during setup can be disabled if not needed.
2. **Available Plugins**:
   - Displays plugins available for installation from the Jenkins plugin repository.
   - Example: Search for `Maven` to install the Maven plugin for Java builds.
3. **Updates**:
   - Shows available updates for installed plugins.
   - Example: If a plugin (e.g., Docker) has a newer version, it appears here for upgrading.
4. **Advanced Settings**:
   - Allows manual installation of specific plugin versions using a URL.

### Plugin Installation Process
1. **Default Plugins**: Install suggested plugins during initial setup.
2. **Additional Plugins**:
   - Go to `Available Plugins`, search for the desired plugin (e.g., `Maven`, `Docker`, `Kubernetes`, `Ansible`, `Terraform`).
   - Select the plugin and click `Install`.
   - Some plugins require a Jenkins restart (check documentation for details).
3. **Specific Version Installation**:
   - Visit the plugin’s official documentation page (e.g., Jenkins plugin site).
   - Navigate to `Releases`, right-click the desired version, and copy the link address.
   - Go to `Advanced Settings`, paste the URL, and click `Deploy` to install the specific version.
   - Example: Install an older version of the Maven plugin if required by the application team.

### Examples
- **Maven Plugin**: Not installed by default; search and install from `Available Plugins`.
- **Docker Plugin**: Install for Docker integration; check releases for specific versions.
- **Periodic Upgrades**: Check the `Updates` tab every 3 months to review new plugin versions and release notes for new features or bug fixes.

### Best Practices
- **Read Documentation**: Understand the purpose, features, and requirements of each plugin before installation.
- **Version Control**: Install specific versions if the latest version is incompatible with project requirements.
- **Restart Requirements**: Some plugins (e.g., `Publish Over SSH`) require a Jenkins restart; check documentation for confirmation.
- **Responsibility**: As administrators, thoroughly review plugin documentation to ensure compatibility with project needs.

---

## Creating Freestyle Projects

### Overview
- **Freestyle Projects**: Manually configured projects for tasks like code compilation, testing, or deployment.
- **Pipeline Projects**: Automated projects using Groovy scripts (to be covered in the next session).

### Creation Steps
1. **Access**: From the Jenkins dashboard, click `New Item`.
2. **Project Details**:
   - Enter a unique project name (e.g., `Freestyle-Project`).
   - Select `Freestyle Project` as the template.
   - Click `OK` to open the configuration page.
3. **Configuration Options**:
   - **General**:
     - Add a description (e.g., “Demo project for build environment”).
   - **Source Code Management (SCM)**:
     - Configure remote repositories (e.g., GitHub).
     - Specify the repository URL, credentials, and branch (e.g., `main`).
   - **Build Triggers**:
     - Enable automated scheduling (e.g., periodic builds).
   - **Build Environment**:
     - Manage workspace settings (e.g., create a new workspace or reuse an existing one).
   - **Build Steps**:
     - Add tasks (e.g., shell scripts, Maven builds, Docker commands).
     - Example: Add a shell script with `echo "Hello World"`.
   - **Post-Build Actions**:
     - Define actions after the build completes (e.g., send email notifications, trigger another job).
     - Example: Configure email notifications for build status.
4. **Save**:
   - Click `Apply` to save without closing or `Save` to save and return to the dashboard.

### Execution
- **Build Now**: From the project dashboard, click `Build Now` to execute the job.
- **Build Status**:
  - Success: Indicated by a green checkmark.
  - Failure: Indicated by a red cross.
- **Console Output**:
  - Click the build status (checkmark or cross) to view the console output.
  - Displays detailed execution logs, including errors (e.g., `ECCHO: command not found`).

### Example
- **Scenario**: Create a freestyle project with a shell script:
  ```bash
  echo "Hello"
  echo "Hello World"
  ECCHO "Invalid Command"
  ```
- **Execution**:
  - First build succeeds for valid commands (`echo "Hello"` and `echo "Hello World"`).
  - Second build fails due to `ECCHO` (invalid command).
- **Console Output**:
  - Shows successful commands and highlights the error (`ECCHO: command not found`).
- **Artifact Creation**:
  - Example: Modify the script to create a file:
    ```bash
    echo "Hello, everyone" > file1.txt
    ```
  - The file is stored in the project’s workspace directory.
  - Access via `Workspace` link on the project dashboard; download as a zip file if needed.

### Key Notes
- Freestyle projects require manual configuration, unlike pipeline projects, which use Groovy scripts for automation.
- Thoroughly test projects before sharing with development teams to ensure reliability.
- Use the console output for troubleshooting, reading each line to identify errors.

---

## Variables in Jenkins

### Types of Variables
1. **Environment Variables**:
   - Predefined by Jenkins to store job-related data (e.g., `JOB_NAME`, `BUILD_NUMBER`, `BUILD_URL`).
   - Used to share job details (e.g., in email notifications).
2. **User-Defined Variables**:
   - Custom variables created by the user to control job execution (e.g., environment selection like `QA`, `UAT`, `Prod`).

### Environment Variables
- **Access**: In the job configuration page, under the build step, click the link for “List of available environment variables.”
- **Examples**:
  - `JOB_NAME`: Name of the job.
  - `BUILD_NUMBER`: Build number (e.g., `3` for the third build).
  - `BUILD_URL`: URL to access the job’s dashboard.
- **Usage**:
  - Syntax: `"${VARIABLE_NAME}"` (enclose variable name in curly brackets, prefix with `$`, and wrap in double quotes).
  - Example Shell Script:
    ```bash
    echo "Jenkins ${JOB_NAME} ${BUILD_NUMBER}"
    ```
  - Output: `Jenkins Freestyle-Project 3` (for the third build of `Freestyle-Project`).
- **Use Case**: Include variables in email notifications to share job details (e.g., `BUILD_URL` for direct access).

### User-Defined Variables
- **Creation**:
  1. Go to the job configuration page.
  2. Under the `General` tab, check `This project is parameterized`.
  3. Click `Add Parameter` and select a parameter type (e.g., `String Parameter`).
  4. Specify:
     - **Name**: Variable name (e.g., `ENV`).
     - **Default Value**: Default value (e.g., `QA`).
     - **Description**: Instructions for users (e.g., “Enter valid environment name: QA, UAT, or Prod”).
- **Usage**:
  - Use the variable in build steps with the same syntax: `"${ENV}"`.
  - Example:
    ```bash
    echo "Deploying to ${ENV}"
    ```
  - At runtime, Jenkins prompts for the parameter value (e.g., `QA`, `UAT`).
- **Use Case**: Control deployment targets (e.g., deploy to `QA` or `UAT` based on runtime input).

### Example
- **Configuration**:
  - Parameter: `ENV`, default value `QA`, description “Enter valid environment name: QA, UAT, or Prod”.
  - Build Step:
    ```bash
    echo "Deploying to ${ENV}"
    ```
- **Execution**:
  - Click `Build with Parameters`, enter `UAT`, and run.
  - Console Output: `Deploying to UAT`.

### Key Notes
- Environment variables are system-defined and read-only; user-defined variables are customizable.
- Use variables to make jobs reusable and dynamic (e.g., deploying to different environments).
- Syntax errors (e.g., missing curly brackets) can cause job failures, so follow the correct format.

---

## Troubleshooting and Console Output

### Importance
- Troubleshooting is a critical DevOps skill to identify and resolve job failures.
- Jenkins provides detailed console output to pinpoint errors.

### Process
1. **Check Build Status**:
   - Green checkmark: Successful build.
   - Red cross: Failed build.
2. **Access Console Output**:
   - Click the build status symbol (checkmark or cross) to view the console output.
   - Alternatively, right-click and open in a new tab for detailed analysis.
3. **Analyze Output**:
   - Read each line to identify where the error occurred.
   - Example: `ECCHO: command not found` indicates an invalid command in the script.
4. **Fix Issues**:
   - Correct the script (e.g., change `ECCHO` to `echo`).
   - Re-run the job and verify the output.

### Best Practices
- **Patience**: Carefully read the entire console output to understand the error context.
- **Testing**: Test jobs thoroughly before sharing with application teams to avoid impacting their workflows.
- **Documentation**: Refer to Jenkins documentation for error codes or plugin-specific issues.

### Example
- **Failed Job**:
  - Script: `ECCHO "Invalid Command"`
  - Console Output: `ECCHO: command not found`
  - Fix: Correct to `echo "Valid Command"` and re-run.

---

## Additional Notes

### Instructor Guidance
- **Active Participation**: Ask questions during the session to clarify doubts immediately, as post-session feedback is less effective.
- **Independent Practice**: Avoid practicing simultaneously with the instructor; use class notes for offline practice.
- **Class Notes**: Review notes before each session (e.g., by 7:30 PM for an 8:00 PM session) to stay prepared.
- **Documentation**: Follow provided documentation step-by-step to avoid errors (e.g., using Ubuntu 22.04 as specified).

### Real-World Context
- **CI/CD Pipelines**: Jenkins is used to automate CI/CD pipelines, including code builds, testing, and deployments to multiple environments (e.g., QA, UAT, production).
- **High Availability**: Production environments typically have multiple servers for redundancy. Jenkins can deploy to these servers using configured remote server settings.
- **DevOps Responsibility**: Administrators are responsible for ensuring job reliability, troubleshooting issues, and maintaining plugins.

### Limitations
- **Offline Usage**: Jenkins requires a network connection as it operates as a web service and interacts with remote servers.
- **Server Capacity**: The number of parallel jobs depends on the server’s capacity (e.g., `t2.micro` cannot handle 100 simultaneous jobs).

---

## Next Steps

### Upcoming Topics
- **Pipeline Projects**: Learn to create automated pipeline projects using Groovy scripts (next session).
- **Jenkins Master and Slave Configuration**: Understand how to set up master and slave nodes for distributed builds.
- **Integration with Docker and Kubernetes**: Configure Jenkins to interact with Docker and Kubernetes clusters for containerized deployments.
- **Remote Server Configuration**: Learn to integrate Jenkins with remote servers (e.g., Tomcat, Kubernetes) for CI/CD pipelines.

### Action Items
1. **Practice Freestyle Projects**:
   - Create a freestyle project with a shell script and test it.
   - Experiment with environment and user-defined variables.
   - Check console output for successful and failed builds.
2. **Review Class Notes**:
   - Go through the shared repository for installation steps and session notes.
   - Fork or bookmark the repository for future reference.
3. **Monitor AWS Usage**:
   - Check the AWS billing dashboard to ensure free tier compliance.
   - Stop instances when not in use.
4. **Explore Plugins**:
   - Visit the Jenkins plugin site to review available plugins and their documentation.
   - Practice installing a plugin (e.g., Maven) and checking its updates.

---

## Resources and Recommendations

### Resources
- **Jenkins Documentation**: [Official Jenkins Website](https://www.jenkins.io/doc/) for plugin details, installation guides, and tutorials.
- **AWS Billing Dashboard**: [AWS Management Console](https://aws.amazon.com/console/) to monitor free tier usage.
- **Class Notes Repository**: Fork or bookmark the shared repository link (provided by the instructor).

### Recommendations
- **Regular Practice**: Spend time daily practicing Jenkins tasks (e.g., creating projects, installing plugins) to build confidence.
- **Documentation Familiarity**: Read plugin release notes to understand new features and bug fixes.
- **Community Engagement**: Join Jenkins or DevOps forums (e.g., Stack Overflow, Jenkins Community) to ask questions and share knowledge.
- **Backup Resources**: Save all shared links and notes locally to ensure access after the instructor’s availability ends.

---
