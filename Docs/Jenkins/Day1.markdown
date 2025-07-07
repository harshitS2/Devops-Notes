# DevOps and Jenkins: Comprehensive Class Notes (Day 1 & Day 2)

This markdown integrates the detailed transcription from Day 1 (July 7, 2025) and the class notes from Day 2 (July 4, 2025). It covers the fundamentals of DevOps, Maven, Jenkins, its architecture, installation process, and CI/CD workflows. The goal is to provide a complete reference for mastering the topics without needing to revisit the video or notes separately.

## Session Overview

- **Day 1**: July 7, 2025
  - **Time**: 09:48 AM IST
  - **Topics**: Introduction to DevOps, Maven as a build tool, Jenkins as a build orchestration tool, Jenkins architecture (master-slave), and Jenkins installation on Ubuntu 22.04.
  - **Key Focus**: Understanding DevOps concepts, Maven's role, Jenkins fundamentals, and practical setup of Jenkins.
  - **Instructor Notes**:
    - Use the chat window for responses, not the Q&A panel.
    - Class notes and recordings are available in a repository.
    - Attendees must set up Jenkins by the next session (Monday, July 14, 2025).
- **Day 2**: July 4, 2025
  - **Topics**: Recap of DevOps, Jenkins architecture, CI/CD workflows, developer vs. DevOps team perspectives, and Jenkins installation prerequisites.
  - **Key Focus**: Reinforcing Jenkins' role in CI/CD, master-slave architecture scenarios, and administrative responsibilities.
- **Objective**: Build a strong foundation in DevOps principles, understand Maven and Jenkins, and prepare for practical Jenkins implementation.

## 1. Introduction to DevOps

- **Definition**:
  - DevOps combines software development (Dev) and IT operations (Ops) to automate and streamline application builds, testing, and deployments.
  - Primary goal: Automate application builds and deployments, but it includes other use cases like monitoring and collaboration.
- **Purpose**:
  - Automate processes such as code compilation, unit testing, artifact creation, and deployment.
  - Enhance collaboration between development and operations teams.
- **Key Activities**:
  - **Code Compilation**: Convert source code into executable artifacts.
  - **Unit Testing**: Validate code functionality using automated tests.
  - **Artifact Creation**: Generate deployable files (e.g., JAR, WAR).
  - **Code Promotion**: Move artifacts through environments (e.g., dev, test, production).
  - **Notification**: Inform teams about build and deployment status.
- **DevOps Process/Stages**:
  - **Continuous Development**: Developers create and commit source code to repositories.
  - **Continuous Integration (CI)**: Automate code integration, build, and testing.
  - **Continuous Delivery/Deployment (CD)**: Automate deployment to test or production environments.

## 2. Maven: The Build Tool

- **Definition**:
  - Maven is a build tool for Java-based applications, automating code compilation, unit testing, and artifact creation.
- **How It Works**:
  - Developers maintain a `pom.xml` (Project Object Model) file in the source code repository.
  - **Components of** `pom.xml`:
    - **Properties**: Project configuration settings.
    - **Dependencies**: External libraries and frameworks required for the build.
    - **Plugins**: Tools for tasks like testing and packaging.
  - Maven uses `pom.xml` to:
    - Compile Java code.
    - Run unit tests (e.g., using JUnit).
    - Create artifacts (e.g., JAR, WAR files).
- **Common Maven Command**:
  - `mvn package`: Generates artifacts for deployment.
- **Key Takeaway**:
  - Understand the role of `pom.xml` and Maven goals (e.g., `package`).
  - Maven will be integrated with Jenkins for automated builds in later demos.

## 3. Jenkins: The Build Orchestration Tool

- **Definition**:
  - Jenkins is an open-source build orchestration tool used to automate end-to-end application builds and deployments.
  - It integrates various DevOps tools to create CI/CD pipelines.
- **Purpose**:
  - Automate the CI/CD workflow, including:
    - Fetching source code from repositories (e.g., GitHub).
    - Building applications using tools like Maven.
    - Running unit tests with tools like JUnit.
    - Creating artifacts and promoting them to test or production environments.
    - Notifying teams about build status.
- **Key Features**:
  - Orchestrates tools like Git, Maven, JUnit, Ansible, Docker, and Kubernetes.
  - Enables automation of complex workflows via CI/CD pipelines.
- **Alternatives to Jenkins**:
  - Azure Pipelines
  - AWS CodeBuild
  - GitLab CI
  - Bamboo
  - GitHub Actions (noted as popular)
- **What Jenkins is NOT**:
  - Jenkins is not a build tool (like Maven); it orchestrates build tools to automate processes.

## 4. Jenkins Architecture: Master-Slave Model

- **Overview**:
  - Jenkins operates on a master-slave architecture to distribute workloads efficiently.
- **Jenkins Master**:
  - A virtual machine (VM) where Jenkins is installed.
  - Responsibilities:
    - Create and manage CI/CD pipeline projects.
    - Schedule build jobs to run on slave nodes.
- **Jenkins Slave**:
  - VMs dedicated to executing build tasks (e.g., compiling code, running tests, creating artifacts).
  - Acts as a build server for specific technologies (e.g., Java, Python).
- **Communication**:
  - Master and slave nodes communicate via SSH.
  - The DevOps team configures this integration.
- **Scenarios for Master-Slave Architecture**:
  - **Scenario 1: Low Build Frequency (Single Technology)**:
    - **Client**: Uses only Java applications with minimal changes (e.g., 2-3 weekly builds, monthly releases).
    - **Recommendation**: Use only a Jenkins master node.
    - **Setup**:
      - Install JDK, Git, Maven, and Jenkins on a single VM.
      - Suitable for low workload and simple processes.
    - **Why**: A single master node can handle the workload without additional infrastructure costs.
  - **Scenario 1.1: High Build Frequency (Single Technology)**:
    - **Client**: Uses Java applications but with high build frequency (e.g., hundreds of daily builds).
    - **Recommendation**: Use master-slave architecture.
    - **Setup**:
      - **Master Node**: Install Jenkins to create and schedule CI/CD pipelines.
      - **Slave Nodes**: Multiple nodes (e.g., SlaveNode1, SlaveNode2) with Java and Maven for load balancing.
    - **Why**: Distributes workload to prevent performance issues on a single node.
  - **Scenario 2: Multiple Technologies with High Build Frequency**:
    - **Client**: Uses diverse technologies (e.g., Java, Python, .NET, Ruby, Node.js, Angular) with frequent builds.
    - **Recommendation**: Use master-slave architecture.
    - **Setup**:
      - **Master Node**: Install Jenkins to create and schedule CI/CD pipelines.
      - **Slave Nodes**:
        - SlaveNode1: Java builds (JDK, Maven).
        - SlaveNode1.1: Additional Java builds for load balancing.
        - SlaveNode2: .NET builds.
        - SlaveNode3: Python builds.
        - SlaveNode4: Node.js/Angular builds.
        - SlaveNode5: Ruby builds.
    - **Why**: Isolates build environments to prevent performance degradation and ensure scalability.
- **Key Benefits of Master-Slave Architecture**:
  - **Load Balancing**: Distributes build tasks across multiple nodes.
  - **Isolation**: Issues in one application build do not affect others.
  - **Scalability**: Add slave nodes as needed for increased workloads.
- **Maintenance**:
  - Periodic cleanup of slave nodes to reduce load.
  - Use automation scripts for server management and provisioning.

## 5. CI/CD Workflow with Jenkins

- **Stages of a CI/CD Pipeline**:
  1. **SCM Checkout**: Fetch source code from a repository (e.g., GitHub) using tools like Git.
  2. **Application Build**: Compile code using build tools (e.g., Maven for Java).
  3. **Unit Testing**: Run automated tests using tools like JUnit or TestNG.
  4. **Create Artifacts**: Generate executable files (e.g., JAR, WAR).
  5. **Promote to Test Environment**: Deploy artifacts to testing environments using tools like Ansible or SSH.
  6. **Notify**: Inform development/testing teams about build status.
  7. **Deploy to Production**: Promote validated artifacts to production using deployment plugins or tools like Ansible.
- **Tools Used in Each Stage**:
  - **Development Environment**:
    - **IDE**: Eclipse, PyCharm, IntelliJ, Visual Studio, Visual Studio Code.
    - **SCM**: Git, GitHub, AWS CodeCommit, Azure Repos.
  - **Build Environment**:
    - **SCM**: Git (to fetch code).
    - **Build**: Maven (for Java compilation and artifact creation).
    - **Unit Testing**: Maven, JUnit.
    - **Promotion**: Ansible, deployment plugins, SSH.
  - **Test Environment**:
    - **Automated Testing**: TestNG, Selenium.
    - **Test Reports**: TestNG, Selenium.
    - **Validation**: TestNG, Selenium.
    - **Production Deployment**: Ansible, deployment plugins, SSH.
- **Jenkins’ Role**:
  - Orchestrates the above tools to automate the entire CI/CD workflow.
  - Creates pipeline projects to execute these stages in sequence or parallel.

## 6. Environments in DevOps

- **Development Environment**:
  - Purpose: Developers create and commit source code.
  - Tools: Eclipse, Git, GitHub.
- **Build Environment**:
  - Purpose: Compile code, run unit tests, and create artifacts.
  - Tools:
    - Git (fetch code).
    - Maven (compile and create artifacts).
    - JUnit (unit testing).
    - Ansible, SSH (promote artifacts to test environment).
- **Test Environment**:
  - Purpose: Perform automated QA testing, generate reports, validate results, and promote to production.
  - Tools:
    - TestNG, Selenium (testing and reporting).
    - Ansible, SSH (production deployment).
- **Production Environment**:
  - Purpose: Deploy validated artifacts for end-user access.
  - Tools: Ansible, deployment plugins, SSH.

## 7. Working with Jenkins: Perspectives

- **Developers’ Perspective**:
  - Role: Consumers of Jenkins, not administrators.
  - Responsibilities:
    - Execute CI/CD pipeline projects.
    - View pipeline outputs in the workspace.
    - Cancel running jobs if needed.
  - Limitation: Developers do not create or manage pipeline projects.
- **DevOps Team Perspective**:
  - Role: Owners and administrators of Jenkins.
  - Responsibilities (aligned with real-time job descriptions):
    - **Installation**: Set up Jenkins and its prerequisites.
    - **Global System Configuration**: Configure system-wide settings.
    - **Plugin Management**: Install and manage plugins for additional functionality.
    - **Tool Management**: Integrate tools like Maven, JUnit, Ansible, etc.
    - **User Management**: Create and manage user profiles for access control.
    - **Security Management**: Ensure secure access to Jenkins.
    - **Credential Management**: Manage credentials for tool integrations.
    - **Master-Slave Configuration**: Set up and integrate master and slave nodes.
    - **CI/CD Pipeline Creation**: Build pipelines to automate builds and deployments.
    - **Application Onboarding**: Integrate client applications into Jenkins pipelines.
    - **Periodic Upgrades**: Update Jenkins and plugins to the latest versions.
    - **Backup and Recovery**: Maintain backups of Jenkins configurations and projects.
    - **Troubleshooting**: Resolve issues related to Jenkins pipelines and services.
  - **Key Takeaway**: These responsibilities are critical for DevOps roles and should be included in resumes.

## 8. Jenkins Installation Process

- **Prerequisites**:
  - **Hardware**: AWS EC2 instance (t2.micro, Ubuntu 22.04 LTS).
  - **Software**: OpenJDK 17 (avoid latest JDK 21 for stability).
  - **Tools**: Git (recommended for SCM).
- **Steps to Install Jenkins on Ubuntu 22.04**:
  1. **Launch an AWS EC2 Instance**:
     - **AMI**: Ubuntu 22.04 (avoid latest version for compatibility).
     - **Instance Type**: t2.micro (free tier eligible).
     - **Key Pair**: Use an existing key pair or create a new one.
     - **Security Group**: Open ports 22 (SSH) and 8080 (Jenkins).
       - Edit inbound rules: Add port 8080 with source `0.0.0.0/0`.
  2. **Log in to the EC2 Instance**:
     - Use an SSH client (e.g., MobaXterm) with the public IP and key pair.
     - Elevate to root: `sudo su`.
  3. **Update Package Repository**:
     - Run: `apt update`.
  4. **Install Git (if not present)**:
     - Check: `git --version`.
     - Install: `apt install git`.
  5. **Install JDK**:
     - Install OpenJDK 17: `apt install openjdk-17-jdk`.
     - Verify: `java --version`.
  6. **Install Jenkins**:
     - Add Jenkins repository key:

       ```bash
       wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
       ```
     - Add Jenkins repository:

       ```bash
       echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
       ```
     - Update package list: `apt update`.
     - Install Jenkins: `apt install jenkins`.
     - Verify: `jenkins --version`.
  7. **Check Jenkins Service Status**:
     - Run: `systemctl status jenkins` (ensure active and running).
     - Service commands:
       - Start: `systemctl start jenkins`
       - Stop: `systemctl stop jenkins`
       - Restart: `systemctl restart jenkins`
       - Enable at boot: `systemctl enable jenkins`
  8. **Post-Installation Configuration**:
     - **Default Directory**: `/var/lib/jenkins` (stores configurations, plugins, credentials).
     - **Unlock Jenkins**:
       - Retrieve initial admin password: `cat /var/lib/jenkins/secrets/initialAdminPassword`.
       - Access Jenkins: `http://<public-ip>:8080`.
       - Paste the password to unlock.
     - **Install Suggested Plugins**:
       - Select "Install suggested plugins" for essential plugins.
     - **Create Admin User**:
       - Enter username, password, full name, and email.
       - Save and continue.
     - **Configure Jenkins URL**:
       - Skip for AWS (public IP changes on restart; use static IP/DNS in production).
     - **Access Jenkins Dashboard**:
       - Click "Start using Jenkins" to view the dashboard.
- **Key Notes**:
  - Jenkins runs as a service on port 8080 by default.
  - Use Ubuntu 22.04 for stability; avoid the latest version.
  - Store the initial admin password securely.
  - Plugins are installed in `/var/lib/jenkins/plugins`.
  - The Jenkins dashboard is accessible via a browser using the public IP and port 8080.

## 9. Key Takeaways for Interviews

- **What is Jenkins?**
  - An open-source build orchestration tool that automates end-to-end application builds and deployments by creating CI/CD pipelines.
- **Jenkins Architecture**:
  - **Master Node**: A VM where Jenkins is installed to create and schedule CI/CD pipeline projects.
  - **Slave Node**: A VM for executing build tasks (compilation, testing, artifact creation).
- **When to Use Master-Slave Architecture**:
  - High build frequency (single or multiple technologies).
  - Diverse technology stacks with frequent builds.
- **DevOps Team Responsibilities**:
  - Installation, configuration, plugin management, tool integration, user management, security, credential management, master-slave setup, pipeline creation, application onboarding, upgrades, backups, and troubleshooting.
- **Common Tools Integrated with Jenkins**:
  - **SCM**: Git, GitHub, AWS CodeCommit, Azure Repos.
  - **Build**: Maven (Java).
  - **Testing**: JUnit, TestNG, Selenium.
  - **Deployment**: Ansible, Docker, Kubernetes, SSH.
- **Orchestration**:
  - Combining multiple DevOps tools to automate processes.
  - Analogy: Like music orchestration, combining instruments to create harmony.

## 10. Action Items for Next Session (Monday, July 14, 2025)

- **Task**: Set up Jenkins on an AWS EC2 instance (Ubuntu 22.04).
  - Follow the installation steps provided above.
  - Ensure the Jenkins dashboard is accessible via `http://<public-ip>:8080`.
- **Preparation**:
  - Review class notes and recordings in the repository (fork/bookmark the link).
  - Practice Linux commands (e.g., `cat`, `apt update`, `systemctl`).
  - Ensure JDK 17, Git, and Jenkins are installed correctly.
- **Expectations**:
  - Be prepared for hands-on demos on Jenkins configuration, pipeline creation, and master-slave setup.
  - Bring specific questions related to the session content.

## 11. Additional Tips for Mastering the Topic

- **Strengthen Linux Fundamentals**:
  - Master commands like `cat`, `apt update`, `systemctl`, and SSH.
  - Review Linux module notes on package management and service control.
  - Example: `cat` displays file contents (e.g., `cat /var/lib/jenkins/secrets/initialAdminPassword`).
- **Practice Jenkins Installation**:
  - Set up a free-tier AWS EC2 instance and follow the installation steps.
  - Troubleshoot common issues:
    - **Port 8080 Blocked**: Check security group rules.
    - **JDK Not Installed**: Verify `java --version`.
    - **Service Not Running**: Use `systemctl status jenkins`.
- **Understand Key Concepts**:
  - Memorize the roles of master and slave nodes.
  - Differentiate build tools (e.g., Maven) from orchestration tools (e.g., Jenkins).
  - Be clear on CI/CD pipeline stages and their tools.
- **Prepare for Interviews**:
  - Add Jenkins administration skills to your resume (e.g., pipeline creation, plugin management, master-slave configuration).
  - Practice explaining master-slave architecture with real-time scenarios (e.g., Scenarios 1, 1.1, 2).
  - Be ready to discuss alternatives like GitHub Actions or Azure Pipelines.
- **Explore Official Documentation**:
  - Jenkins Installation Guide: Detailed instructions for Linux, Windows, Docker, etc.
  - Reference for prerequisites, plugins, and configuration.
- **Engage Actively**:
  - Use the chat window for relevant questions during sessions.
  - Avoid distractions (e.g., unrelated questions about Ruby or GitHub Actions).
  - Raise issues immediately to resolve them during the session.

## 12. Repository and Resources

- **Class Notes Repository**:
  - Contains:
    - Installation documentation.
    - Class notes for Day 1 and Day 2.
    - Reference links (e.g., Jenkins official documentation).
  - **Action**: Fork or bookmark the repository link provided by the instructor.
- **Official Jenkins Resources**:
  - Jenkins Installation on Linux
  - Guides for installing Jenkins on various platforms (Ubuntu, Fedora, RHEL, Windows, Docker, etc.).

## 13. Common Issues and Troubleshooting

- **Network Issues**:
  - Ensure a stable internet connection.
  - Rejoin the session if audio or connectivity issues occur.
- **Jenkins Installation Errors**:
  - **Port 8080 Blocked**: Verify security group rules in AWS (port 8080, source `0.0.0.0/0`).
  - **JDK Not Installed**: Ensure OpenJDK 17 is installed (`java --version`).
  - **Service Not Running**: Check `systemctl status jenkins` and start if needed (`systemctl start jenkins`).
  - **Invalid Admin Password**: Retrieve from `/var/lib/jenkins/secrets/initialAdminPassword`.
- **Accessing Jenkins Dashboard**:
  - Use the public IP with port 8080 (`http://<public-ip>:8080`).
  - Avoid private IP for external access; use within the same network only.
- **Plugin Installation Issues**:
  - Ensure internet connectivity during plugin installation.
  - Select "Install suggested plugins" for default setup.

## 14. Q&A and Instructor Feedback

- **Common Questions**:
  - **What is a Jenkins master node?**
    - A VM where Jenkins is installed to create and schedule CI/CD pipeline projects.
  - **What is a Jenkins slave node?**
    - A VM for executing build tasks, acting as a build server.
  - **What is orchestration?**
    - Combining DevOps tools to automate processes, similar to musical orchestration.
  - **How do developers access Jenkins?**
    - Via user profiles created by the DevOps team, accessed through a browser.
  - **What are post-installation activities?**
    - Unlocking Jenkins, installing plugins, creating an admin user, and configuring the Jenkins URL.
  - **What is the default Jenkins directory?**
    - `/var/lib/jenkins` (stores configurations, plugins, credentials).
  - **Why avoid the latest Ubuntu version?**
    - Compatibility issues with Jenkins; use Ubuntu 22.04 for stability.
- **Instructor Feedback**:
  - Avoid irrelevant questions (e.g., Ruby, GitHub Actions) in the Q&A panel.
  - Use the chat window for responses and relevant questions.
  - Identify yourself in the chat to avoid confusion (e.g., anonymous attendees).
  - Raise audio or delivery issues immediately for resolution.
  - Revisit Linux fundamentals (e.g., `cat`, `apt`) to strengthen understanding.
