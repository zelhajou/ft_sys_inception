
![ascii-text-art (2)](https://github.com/user-attachments/assets/4e511c34-43f2-4d33-8186-a66a68d668aa)

# Inception

## Overview
Inception is a System Administration project focused on Docker containerization and service orchestration. The project implements a small-scale but production-ready infrastructure using Docker Compose, creating a secure and modular web hosting environment.

## Infrastructure
The project consists of three main services, each running in its own container:

- **NGINX Container**: Front-facing web server with SSL/TLS encryption
- **WordPress + PHP-FPM Container**: Application server for WordPress
- **MariaDB Container**: Database server for persistent data storage

**Key Features**:

- 🔐 SSL/TLS encryption (v1.2/1.3) for secure communication
- 🐳 Custom Docker images built from Alpine Linux
- 📦 Persistent data storage using Docker volumes
- 🔄 Automatic container restart on failure
- 🌐 Custom domain name configuration
- 🔒 Environment variable management for sensitive data

**Architecture**:

![diagram2](https://github.com/user-attachments/assets/3da6c1b8-f43e-4dd0-99be-ef03d404799d)



## Technologies

- Docker & Docker Compose
- NGINX with SSL/TLS
- WordPress & PHP-FPM
- MariaDB
- Alpine Linux
- Bash Scripting

## Table of Contents

- [Overview](#overview)
- [Infrastructure](#infrastructure)
- [Technologies](#technologies)
- [Table of Contents](#table-of-contents)
- [Deep Dive into Containers](#deep-dive-into-containers)
	- [What is a Container?](#what-is-a-container)
	- [How Containers Differ from Virtual Machines](#how-containers-differ-from-virtual-machines)
	- [Key Concepts in Containers](#key-concepts-in-containers)
		- [Container Images](#container-images)
		- [Container Runtime](#container-runtime)
		- [Linux Containers (LXC)](#linux-containers-lxc)
		- [Namespaces](#namespaces)
		- [Control Groups (cgroups)](#control-groups-cgroups)
		- [Container Networking](#container-networking)
		- [Volumes and Persistent Storage](#volumes-and-persistent-storage)
		- [Orchestration](#orchestration)
	- [Understanding Docker](#understanding-docker)
		- [What is Docker?](#what-is-docker)
		- [Docker Architecture](#docker-architecture)
			- [1. Docker Client](#1-docker-client)
			- [2. Docker Daemon](#2-docker-daemon)
			- [3. Docker Engine](#3-docker-engine)
			- [4. Docker Registry](#4-docker-registry)
			- [5. Docker Images:](#5-docker-images)
			- [6. Docker Containers](#6-docker-containers)
		- [Docker Workflow](#docker-workflow)
			- [1. Building Docker Images](#1-building-docker-images)
			- [2. Shipping Docker Images](#2-shipping-docker-images)
			- [3. Running Docker Containers](#3-running-docker-containers)
			- [4. Volumes and Persistent Storage](#4-volumes-and-persistent-storage)

	
- [Inception Setup and Configuration](#inception-setup-and-configuration)
	- [Setp 1: Setting up the Virtual Machine](#setp-1-setting-up-the-virtual-machine)
	- [Step 2: Setting up Docker and Docker Compose](#step-2-setting-up-docker-and-docker-compose)

- [Tools](#tools)
- [Resources](#resources)
	- [YouTube Summaries and Tutorials](#youtube-summaries-and-tutorials)


## Deep Dive into Containers

### What is a Container?

A container is a lightweight, stand-alone, and executable software package that includes everything needed to run a piece of software, including the code, runtime, system tools, libraries, and settings. Containers leverage the host operating system's kernel, making them more efficient than traditional virtual machines (VMs), which require a full OS instance for each application.

<div align="center">
	
![why-containers](https://github.com/user-attachments/assets/508629cd-5bed-4ca3-9223-2bad4a2e824d)

</div>

- [OFFICIAL - What is a container? ](https://www.docker.com/resources/what-container/)
- [IBM Technology - Containerization Explained](https://youtu.be/0qotVMX-J5s)
- [IBM Technology - Virtualization Explained](https://youtu.be/FZR0rG3HKIk)
- [IBM Technology - Containers vs VMs: What's the difference?](https://youtu.be/cjXI-yxqGTI)

- [Virtual Machines vs Containers](https://youtu.be/eyNBf1sqdBQ)
- [VMware Cloud Native Apps - Intro to Containers](https://www.youtube.com/playlist?list=PL7bmigfV0EqQt5_pBPQ8tsZjI1w68-e0H)
- [Tiny Technical Tutorial - Containers in AWS | For Absolute Beginners](https://youtu.be/NI34uF7VVP8)
- [Metwally Labs - Container Stroy [AR]](https://youtu.be/jPzJVH1ab-4)

### How Containers Differ from Virtual Machines

<div align="center">
	
![1_QAP008mUYPODZMEBb6Wpdg](https://github.com/user-attachments/assets/1859cf1d-094d-443a-89b7-2dbcf4e6f39d)

</div>

1. **Resource Efficiency:**
	- **Containers** share the host OS kernel and isolate the application processes from the rest of the system, allowing for multiple containers to run on the same host without the overhead of multiple operating systems.
	- **Virtual Machines** (VMs), on the other hand, include a full copy of an operating system and a hypervisor layer, which requires more system resources.
2. **Isolation:**
	- **Containers** provide process-level isolation. Each container operates in its own isolated user space but shares the OS kernel with other containers.
	- **VMs** provide hardware-level isolation, where each VM is fully isolated from others at the hardware level, with its own OS and kernel.
3. **Portability:**
	- **Containers** are highly portable due to their lightweight nature. They can run on any system that has a container runtime (like Docker) without the need to adjust for different environments.
	- **VMs** are less portable since they are tied to the specific hypervisor and OS configuration.

### Key Concepts in Containers

<div align="center">
	
![big-idea-every-dependency](https://github.com/user-attachments/assets/6905ac47-9877-4a4c-8761-66c2d1159417)

</div>


1. **Container Images:**
	- A container image is a static snapshot that contains all the dependencies and configurations needed to run a containerized application. It's built from a series of layers, where each layer represents a change or instruction in the Dockerfile.
	- **Layers**: Each layer in a container image represents a filesystem change (like installing software or adding files). Layers are cached, so reusing layers can make building containers faster.
	- **Union Filesystem**: This allows container layers to be stacked, and changes to the filesystem can be made in a new layer without altering the layers below.

<div align="center">
	
![layers](https://github.com/user-attachments/assets/850790b7-4392-47b8-995c-9f8964ce27c5)

</div>

2. **Container Runtime:**
	- The container runtime is the software that executes containers. The most popular runtime is Docker, which manages the entire lifecycle of containers from creation, starting, stopping, and destroying.
	- **Docker Engine**: The core part of Docker that runs containers. It consists of three main components:
		- **Docker Daemon**: Manages the containers on the host system.
		- **REST API**: Allows communication with the Docker Daemon via a client.
		- **Docker CLI**: A command-line tool to interact with Docker.

![1_c3AiZFHuib7FUGyINzkEag](https://github.com/user-attachments/assets/98d3fe07-2a59-48f4-90f8-0e955d83c690)

---

<div align="center">

![containers-are-processes](https://github.com/user-attachments/assets/63742f7a-4743-4c82-9d22-bc5b8e8117dd)

---

![kernel-features](https://github.com/user-attachments/assets/1bea7820-d908-4a1c-a92a-13c95e77505b)

</div>


3. **Linux Containers (LXC)**
	- Linux Containers (LXC) is a containerization technology that uses Linux kernel features like cgroups and namespaces to provide an isolated environment for applications. It is the foundation for Docker and other container platforms.
	- **Cgroups (Control Groups)**: A Linux kernel feature that limits, accounts for, and isolates the resource usage of a process group. It allows you to allocate resources like CPU, memory, disk I/O, and network bandwidth to containers.
	- **Namespaces**: A Linux kernel feature that isolates system resources like process IDs, network interfaces, and filesystems. Namespaces ensure that each container has its own isolated instance of global system resources.
	- **Union Filesystems**: A method of combining multiple directories into a single directory that appears to contain only their unique files. This allows for layering in container images and efficient use of disk space.

4. **Namespaces:**
	- Namespaces provide the first layer of isolation in containers. They ensure that each container has its own isolated instance of global system resources.   
<div align="center">
	
![namespaces](https://github.com/user-attachments/assets/0a6cccb0-9bd9-439e-bcc9-15ef2634f4d4)

</div>

- **Types of Namespaces**:
	- **PID Namespace**: Isolates process IDs (PIDs), so processes in a container are independent of those in another container or the host.
 
		![pid-namespaces](https://github.com/user-attachments/assets/d6e9ba29-d006-4c75-a9c2-520c85e51c4e)

  	- **NET Namespace**: Isolates network interfaces, IP addresses, and routing tables.

  	  	![network-namespaces](https://github.com/user-attachments/assets/87a85518-2624-4906-916b-d2ebd609ed62)

	- **MNT Namespace**: Isolates mount points, allowing containers to have their own filesystem.
	- **UTS Namespace**: Isolates hostname and domain name, so each container can have its own hostname.
	- **IPC Namespace**: Isolates interprocess communication mechanisms, like message queues.
	- **USER Namespace**: Isolates user and group IDs, so users in a container can be mapped to different users on the host.
   
		![user-namespaces](https://github.com/user-attachments/assets/e09b4235-b8d4-4534-b1ff-b7f2512a3fac)

---

<div align="center">
	
![how-to-namespace](https://github.com/user-attachments/assets/6d2fd466-e911-4ea4-a8c1-14867ff6772c)

</div>

5. **Control Groups (cgroups):**
	- Cgroups are used to limit, account for, and isolate the resource usage of process groups. They allow the allocation of CPU, memory, disk I/O, and network bandwidth to containers.
	- **Resource Limits**: Cgroups ensure that containers do not consume more than the allocated resources, protecting the host system from being overwhelmed by any single container.
	
	![cgroups](https://github.com/user-attachments/assets/6912fdef-687c-476b-80de-f3a62496fb91)


The combination of namespaces and cgroups provides the foundation for containerization, allowing containers to be isolated from each other and the host system.

- This is a good video that implements the concept of namespaces and cgroups in a simple way [Live Code: Understanding Container Internals](https://youtu.be/9ivFrXgB2Zg)

6. **Container Networking:**
- Containers can be networked together, isolated, or connected to external networks.
- **Docker Networking Modes**:
	- **Bridge Mode**: The default mode, where containers are connected to a private internal network and communicate via the host machine.
	- **Host Mode**: The container shares the host machine's network stack, which can lead to performance improvements but less isolation.
	- **Overlay Network**: Used for multi-host networking, allowing containers across different hosts to communicate securely.

7. **Volumes and Persistent Storage**:

- Containers are ephemeral, meaning any data written inside a container’s filesystem is lost when the container is stopped or destroyed. To persist data, Docker uses volumes.
- **Volumes**: A volume is a directory or a file outside of the container’s filesystem that remains intact across container restarts. Volumes are stored on the host machine and can be shared between containers.
- **Bind Mounts**: A specific type of volume where a host directory is mounted directly into a container.

8. **Orchestration**:
- When dealing with multiple containers that need to work together, orchestration tools are used to manage container deployment, scaling, and networking.
- **Docker Compose**: A tool for defining and running multi-container Docker applications. With a single YAML file, you can configure all the services your application needs.
- **Kubernetes**: A powerful open-source system for automating the deployment, scaling, and management of containerized applications across clusters of hosts.


## Understanding Docker

### What is Docker?

Docker is an open-source platform that automates the deployment of applications inside lightweight, portable containers. It abstracts away many of the complexities involved in managing different environments, allowing developers to focus on writing code that works consistently from development to production.

### Docker Architecture

Docker is built on a client-server architecture, which includes the following components:

![docker-architecture-ezgif com-webp-to-png-converter](https://github.com/user-attachments/assets/0a251bbc-1013-4751-84bc-a0022c3d9c75)

#### 1. Docker Client

- The Docker Client is the primary way users interact with Docker. When you run commands like `docker run` or `docker build`, the Docker Client sends these commands to the Docker Daemon.
- **Command-Line Interface (CLI)**: Docker provides a simple CLI that allows you to interact with Docker easily.

#### 2. Docker Daemon

- The Docker daemon (`dockerd`) is a persistent background process that manages Docker containers and images. It listens for Docker API requests and manages Docker objects like images, containers, networks, and volumes.

#### 3. Docker Engine

- Docker Engine is the core component of Docker, consisting of the Docker Daemon, REST API, and the Docker CLI. It’s responsible for managing containers, images, networks, and volumes.

#### 4. Docker Registry

- A Docker Registry is a storage and distribution system for Docker images. The most common public registry is Docker Hub, where you can find and share container images.
- **Private Registries**: Organizations can also set up private registries to host their images securely.

#### 5. Docker Images

- Docker images are read-only templates used to create containers. An image includes everything needed to run an application: code, runtime, libraries, environment variables, and configuration files.
- **Layered Filesystem**: Docker images are made up of layers, with each layer representing a set of filesystem changes. This layering system makes Docker images lightweight and easy to share.

#### 6. Docker Containers

- Containers are instances of Docker images that can be run, stopped, and restarted. Containers are isolated from each other and the host system but can share resources, such as files and networking, as needed.
- **Isolation**: Containers isolate applications from each other and the underlying host, ensuring that each application runs in its own environment.

### Docker Workflow

The typical workflow in Docker involves building, shipping, and running containers:

#### 1. Building Docker Images

- You create a Docker image using a `Dockerfile`, which is a script of instructions on how to build the image.
- **Dockerfile**: The Dockerfile is a plain text file that contains a series of instructions for building a Docker image. Each instruction in the Dockerfile creates a layer in the final image.

	- **Basic Instructions:**
		- `FROM`: Specifies the base image to start from.
		- `RUN`: Executes a command and creates a new layer in the image.
		- `COPY`: Copies files or directories from the host system to the image.
		- `ADD`: Similar to `COPY`, but can also fetch files from URLs and extract tarballs.
		- `CMD`: Specifies the command to run when the container starts.
		- `ENTRYPOINT`: Sets the default executable for the container.
		- `EXPOSE`: Informs Docker that the container listens on a specific network port.
		- `ENV`: Sets environment variables in the container.
		- `WORKDIR`: Sets the working directory for commands in the container.
		- `MAINTAINER`: Specifies the author of the image.
- After creating a Dockerfile, you build the image using the command `docker build`, which reads the Dockerfile and creates the image.

#### 2. Shipping Docker Images

- Once an image is built, it can be shared by pushing it to a Docker Registry, such as Docker Hub or a private registry.
- **Pushing and Pulling Images:**
	- `docker push`: Uploads a local image to a registry.
	- `docker pull`: Downloads an image from a registry to the local machine.

#### 3. Running Docker Containers

- To run an application, you create a container from a Docker image using the `docker run` command.

- **Managing Containers:**
	- `docker run`: Creates and starts a container from an image.
	- `docker start`: Starts a stopped container.
	- `docker stop`: Stops a running container.
	- `docker rm`: Removes a container.
	- `docker ps`: Lists running containers.
	- `docker ps -a`: Lists all containers, including stopped ones.
	- `docker exec`: Runs a command in a running container.
	- `docker logs`: Displays the logs of a container.
	- `docker inspect`: Shows detailed information about a container or image.

- **Port Mapping**: You can map container ports to host ports using the `-p` flag in the `docker run` command, enabling external access to services running inside the

#### 4. Volumes and Persistent Storage

- **Volumes**: Docker volumes are used to persist data generated by and used by Docker containers. Volumes are stored outside the container’s filesystem and can be shared among multiple containers.

- **Mount types**:
	- **Volume Mounts**: Managed by Docker and stored in the host filesystem.
	- **Bind Mounts**: Bind a specific path on the host to a path inside the container.
	- **Tmpfs Mounts**: Create a temporary filesystem in memory for a container.


#### 5. Networking in Docker

Docker provides various networking modes that define how containers communicate with each other and the outside world.

- **Bridge Network**: The default network mode, where each container is connected to an isolated network on the host.
- **Host Network**: The container shares the host’s network stack, removing the network isolation between container and host.
- **Overlay Network**: Used in Docker Swarm or Kubernetes to connect containers across different hosts.

### Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications. It uses a YAML file to configure the application’s services, networks, and volumes, allowing you to define a multi-container environment with a single command.

## Inception Setup and Configuration

### Setp 1: Setting up the Virtual Machine

- **VirtualBox Installation:**
	- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) on your host machine.
	- Create a new VM with the following settings:
		- **Name**: Inception
		- **Type**: Linux
		- **Version**: Alpine (64-bit)
		- **Memory**: 2 GB
		- **Hard Disk**: Create a new virtual hard disk now (VDI, dynamically allocated, 20 GB)
	- Start the VM and install Alpine Linux on it.

- **Alpine Linux Installation:**
	- Download the [Alpine Linux ISO](https://alpinelinux.org/downloads/) and attach it to the VM.
	- Boot the VM from the ISO and follow the on-screen instructions to install Alpine Linux.
	- Set up the root password and create a new user account.
	- Update the system and install the necessary packages (e.g., `sudo`, `bash`, `vim`).

### Step 2: Setting up Docker and Docker Compose

- **Docker Installation:**
	- Install Docker on Alpine Linux by running the following commands:
		```bash
		sudo apk update
		sudo apk add docker docker-compose
		sudo apk add --update docker openrc
		sudo rc-update add docker boot
		sudo service docker start
		```
	- Add your user to the `docker` group to run Docker commands without `sudo`:
		```bash
		sudo adduser <username> docker
		```
	- Log out and log back in to apply the changes.

- **Docker Compose CLI Installation:**
	- Install Docker Compose using the following commands:
		```bash
		sudo apk add docker-cli-compose
		```
	- Verify the installation by running `docker-compose --version`.


For these two previous steps, you can follow the instructions in the following repository for a more detailed guide : [Inception-Guide](https://github.com/Vikingu-del/Inception-Guide)


### Step 3: Setting up the Docker Environment

- **Project Structure:**

```bash
└── inception
    └── srcs
        └── requirements
            ├── mariadb
            │   ├── Dockerfile
            │   ├── conf
            │   └── tools
            ├── nginx
            │   ├── Dockerfile
            │   ├── conf
            │   └── tools
            └── wordpress
                ├── Dockerfile
                ├── conf
                └── tools
```


### Step 4: Building Dockerfiles for Each Service


<!--
![Diagram](https://github.com/user-attachments/assets/6b3e7b16-3949-44ad-b824-1471ea40ae4a)
-->


#### [Step 4.1: MariaDB Dockerfile](https://github.com/zelhajou/42cursus-inception/tree/main/inception/srcs/requirements/mariadb)
#### [Step 4.2: WordPress Dockerfile]()
#### [Step 4.3: NGINX Dockerfile]()

### Step 5: Setting up Docker Compose

#### [Step 5.1: Creating a Docker Compose File]()



	


## Tools

- [https://labs.play-with-docker.com/](https://labs.play-with-docker.com/) :  



## Resources

### YouTube Summaries and Tutorials

- [ Youtube - Professeur Mohamed YOUSSFI - Virtualisation et Containérisation : VirtualBox DOCKER KUBERNETES](https://youtube.com/playlist?list=PLxr551TUsmApVwBMzhtLqrWqcKQs4sh19&si=W0Y5nBVF4gC4Hi5k)
 	- <details>
		<summary>
			Partie 1 Virtualisation et Containerisation Docker - Retour sur Architecture de Base des Ordinateurs
		</summary>
		
		- **Fonctionnement de base des ordinateurs**: Les ordinateurs sont composés de deux parties principales : le matériel (hardware) et le logiciel (software). Le matériel inclut tous les composants physiques de l'ordinateur, tels que le microprocesseur (CPU), la mémoire vive (RAM), et les dispositifs de stockage comme les disques durs. Le logiciel, quant à lui, est constitué des programmes et des systèmes d'exploitation qui dirigent le matériel pour effectuer des tâches spécifiques.
		- **Microprocesseur (CPU)**: Le microprocesseur est souvent considéré comme le "cerveau" de l'ordinateur. Il effectue les calculs arithmétiques et logiques nécessaires pour exécuter les programmes. Historiquement, l'évolution des microprocesseurs a été marquée par une augmentation constante de leur puissance et de leur complexité, conformément à la loi de Moore, qui stipule que le nombre de transistors dans un microprocesseur double environ tous les 18 mois, augmentant ainsi ses performances.
		-  **Évolution des microprocesseurs**: Au fil des années, les microprocesseurs ont connu une série d'améliorations significatives. À l'origine, les microprocesseurs comme le 8086 ont été progressivement remplacés par des versions plus avancées telles que les 286, 386, 486, et finalement le Pentium. Chaque génération apportait des augmentations de la fréquence d'horloge, ce qui permettait des calculs plus rapides.
		
			Cependant, cette course à la fréquence élevée a rencontré des limitations physiques, notamment des problèmes de surchauffe. Le Pentium 4, par exemple, malgré une fréquence élevée, souffrait de surchauffe, ce qui diminuait ses performances.
		
			**Introduction des processeurs multi-cœurs**
		   
			Pour surmonter ces limitations, les fabricants de microprocesseurs ont introduit des architectures multi-cœurs. Plutôt que d'augmenter indéfiniment la fréquence d'horloge, ils ont commencé à intégrer plusieurs cœurs de traitement dans un seul processeur. Cela permet aux ordinateurs d'exécuter plusieurs instructions simultanément, améliorant ainsi les performances de manière significative sans augmenter la fréquence d'horloge.
		
		- **Unités de traitement graphique (GPU)**: Parallèlement à l'évolution des CPU, les unités de traitement graphique (GPU) ont également progressé. Initialement conçues pour accélérer le rendu graphique dans les jeux vidéo, les GPU sont devenus des outils puissants pour les calculs parallèles massifs. Nvidia, par exemple, a développé des GPU capables de traiter des milliers de petites tâches en parallèle, ce qui est particulièrement utile pour des applications comme l'apprentissage automatique et l'intelligence artificielle.
		- **Importance du BIOS et du processus de démarrage**: Le BIOS (Basic Input/Output System) est le premier programme qui s'exécute lorsqu'un ordinateur est allumé. Il initialise et teste le matériel avant de charger le système d'exploitation à partir du disque dur ou d'un autre dispositif de démarrage. Ce processus comprend un auto-test de démarrage qui vérifie le bon fonctionnement des composants matériels.
		- **Mémoire et stockage**: Deux types de mémoire sont essentiels dans un ordinateur : la mémoire vive (RAM) et les dispositifs de stockage persistants comme les disques durs. La RAM est volatile, ce qui signifie que son contenu est perdu lorsque l'ordinateur est éteint, tandis que les disques durs offrent un stockage permanent des données et des programmes.
		- **Sécurité et mises à jour du BIOS**: Historiquement, le BIOS était stocké dans des mémoires mortes (ROM), ce qui le rendait difficile à mettre à jour. Cependant, avec l'introduction des mémoires flash (EEPROM), il est devenu possible de mettre à jour le BIOS par voie électronique, ce qui a résolu de nombreux problèmes de sécurité et de compatibilité.
  		- **Conclusion**: La compréhension des bases de l'architecture des ordinateurs et de leur évolution est essentielle pour appréhender des concepts avancés comme la virtualisation et la containerisation. La transition vers des architectures multi-cœurs et l'utilisation de GPU pour les calculs parallèles ont transformé les capacités des ordinateurs modernes, ouvrant la voie à des innovations dans des domaines tels que l'intelligence artificielle et l'apprentissage automatique. La virtualisation et la containerisation, avec des outils comme Docker, permettent de maximiser l'utilisation de ces ressources matérielles, rendant les systèmes informatiques plus flexibles et efficaces. 

 	- <details>
		<summary>
			Partie 2 Virtualisation et Containerisation - Bases de la virtualisation
		</summary>
  		
		- **Introduction à la virtualisation**: La virtualisation est une technologie qui permet de créer plusieurs environnements virtuels sur une seule machine physique. Cette technologie a révolutionné l'informatique moderne en permettant une utilisation plus efficace des ressources matérielles et en offrant une flexibilité accrue pour l'exécution de différents systèmes d'exploitation et applications.
		- **Composants virtuels**: Dans un environnement de virtualisation, les composants matériels traditionnels tels que les disques durs, les cartes réseau et les adaptateurs sont virtualisés. Cela signifie que des versions logicielles de ces composants sont créées et utilisées par les machines virtuelles. Ces composants virtuels fonctionnent comme des proxys, traduisant les opérations virtuelles en opérations physiques sur le matériel réel.

			**Disque dur virtuel**

			Un disque dur virtuel est une image de disque qui agit comme un disque dur physique pour la machine virtuelle. Il stocke les données de la même manière qu'un disque dur traditionnel, mais son contenu est en réalité stocké dans un fichier sur le disque dur physique de l'hôte.
 
			**Carte réseau virtuelle**
 
			Une carte réseau virtuelle permet à une machine virtuelle de se connecter à un réseau de la même manière qu'une carte réseau physique. Elle utilise les interfaces réseau physiques de l'hôte pour envoyer et recevoir des données.

		- **Fonctionnement des machines virtuelles**: Les machines virtuelles sont créées et gérées par des logiciels appelés hyperviseurs. Un hyperviseur est responsable de l'allocation des ressources matérielles (comme le CPU, la mémoire et le stockage) aux machines virtuelles et de la gestion de leur exécution. Il existe deux types principaux d'hyperviseurs :

			**Hyperviseurs de type 1**
 
			Les hyperviseurs de type 1, également appelés hyperviseurs "bare-metal", s'exécutent directement sur le matériel physique de l'hôte. Ils offrent des performances supérieures car ils ont un accès direct aux ressources matérielles sans passer par un système d'exploitation intermédiaire. Exemples : VMware ESXi, Microsoft Hyper-V.

			**Hyperviseurs de type 2**
 
			Les hyperviseurs de type 2, également appelés hyperviseurs "hosted", s'exécutent sur un système d'exploitation hôte. Ils sont plus flexibles et plus faciles à installer car ils peuvent être exécutés comme n'importe quelle autre application sur l'hôte. Exemples : VMware Workstation, VirtualBox.

		- **Performance et partage des ressources**: L'un des défis de la virtualisation est le partage des ressources matérielles entre plusieurs machines virtuelles. Chaque machine virtuelle utilise une partie des ressources du CPU, de la mémoire et du stockage de l'hôte. L'hyperviseur doit gérer ce partage de manière efficace pour éviter que les machines virtuelles n'interfèrent les unes avec les autres.
 
  			**Gestion des ressources**
 
			L'hyperviseur alloue dynamiquement les ressources en fonction des besoins de chaque machine virtuelle. Par exemple, si une machine virtuelle nécessite plus de CPU pour une tâche intensive, l'hyperviseur peut lui allouer plus de cycles CPU temporaires tout en réduisant la part allouée à une autre machine virtuelle moins active.


		- **Virtualisation complète et paravirtualisation** Il existe deux principaux types de virtualisation : la virtualisation complète et la paravirtualisation.

			**Virtualisation complète**
 
			Dans la virtualisation complète, le système d'exploitation invité fonctionne comme s'il était sur un matériel physique réel. Il n'est pas conscient qu'il est dans un environnement virtualisé. Cela simplifie la compatibilité car n'importe quel système d'exploitation peut être exécuté sans modification. Cependant, cette méthode peut entraîner une légère diminution des performances en raison de la couche d'abstraction supplémentaire.

		  	**Paravirtualisation**
 
			Dans la paravirtualisation, le système d'exploitation invité est modifié pour être conscient de son environnement virtualisé. Cela permet d'optimiser les performances en permettant un accès direct aux ressources matérielles. Cependant, cela nécessite des modifications au système d'exploitation invité, ce qui peut limiter les options de compatibilité.

		- **Conclusion**

  			La virtualisation est une technologie puissante qui permet de maximiser l'utilisation des ressources matérielles, d'améliorer la flexibilité et de simplifier la gestion des environnements informatiques. En comprenant les différents composants et types de virtualisation, ainsi que les rôles des hyperviseurs, les professionnels de l'informatique peuvent mieux tirer parti de cette technologie pour répondre aux besoins de leurs organisations.
	  </details>
 	- <details>
		<summary>
			Partie 3 Virtualisation et Containerisation - Bases de Virtual Box
		</summary>
 
	  	- **Introduction à la virtualisation**: La virtualisation est une technologie qui permet de créer plusieurs environnements virtuels sur une seule machine physique. Cette technologie a révolutionné l'informatique moderne en permettant une utilisation plus efficace des ressources matérielles et en offrant une flexibilité accrue pour l'exécution de différents systèmes d'exploitation et applications.
   		- **Installation de VirtualBox**: Pour installer VirtualBox, téléchargez simplement la version appropriée pour votre système d'exploitation (Windows, macOS, Linux) depuis le site officiel de VirtualBox. L'installation suit un processus classique où vous devez accepter les termes de la licence et suivre les instructions à l'écran pour compléter l'installation.
		- **Création d'une machine virtuelle**: Une fois VirtualBox installé, vous pouvez commencer à créer des machines virtuelles. Voici les étapes pour créer une machine virtuelle sous VirtualBox :

			1. **Ouvrir VirtualBox**: Lancez le logiciel VirtualBox.
			2. **Créer une nouvelle machine virtuelle**: Cliquez sur "Nouvelle" pour ouvrir l'assistant de création de machine virtuelle.
			3. **Nom et type de système d'exploitation**: Donnez un nom à votre machine virtuelle et sélectionnez le type et la version du système d'exploitation que vous allez installer. Par exemple, pour installer Ubuntu, sélectionnez "Linux" et "Ubuntu (64-bit)".
			4. **Allocation de mémoire**: Allouez la quantité de mémoire RAM à la machine virtuelle. Une allocation de 2048 Mo (2 Go) est recommandée pour les systèmes Linux.
			5. **Création d'un disque dur virtuel**: Sélectionnez l'option pour créer un nouveau disque dur virtuel et choisissez le format du fichier de disque dur (VDI est recommandé). Vous pouvez également choisir entre une allocation dynamique ou une taille fixe pour le disque dur virtuel.
			6. **Configuration finale**: Passez en revue les paramètres et terminez la création de la machine virtuelle.

		- **Configuration de la machine virtuelle**: Une fois la machine virtuelle créée, vous pouvez ajuster ses paramètres selon vos besoins :
    
			1. **Ordre de démarrage**: Modifiez l'ordre de démarrage pour que la machine virtuelle démarre à partir du lecteur CD/ISO en premier, puis du disque dur.
			2. **Processeurs**: Vous pouvez allouer plusieurs cœurs de processeur à la machine virtuelle en fonction des ressources disponibles sur votre machine hôte.
			3. **Stockage**: Ajoutez des images ISO ou des disques durs virtuels supplémentaires à la machine virtuelle.

		- **Installation du système d'exploitation**: Pour installer un système d'exploitation sur la machine virtuelle, suivez ces étapes :

  			1. **Télécharger l'image ISO**: Téléchargez l'image ISO du système d'exploitation que vous souhaitez installer (par exemple, Ubuntu).
			2. **Monter l'image ISO**: Dans les paramètres de la machine virtuelle, allez dans l'onglet "Stockage", sélectionnez le lecteur optique, et montez l'image ISO téléchargée.
			3. **Démarrer la machine virtuelle**: Démarrez la machine virtuelle. Elle devrait démarrer à partir de l'image ISO et lancer le processus d'installation du système d'exploitation.
			4. **Suivre les instructions d'installation**: Suivez les instructions à l'écran pour installer le système d'exploitation dans la machine virtuelle.


		- **Connectivité réseau**: VirtualBox propose plusieurs modes de connectivité réseau pour les machines virtuelles :
 
		  	1. **NAT (Network Address Translation)**: Par défaut, VirtualBox utilise le mode NAT, qui permet à la machine virtuelle d'accéder à Internet mais empêche les connexions entrantes depuis l'extérieur.
			2. **Bridge Networking**: Ce mode connecte la machine virtuelle directement au réseau physique de l'hôte, lui permettant d'obtenir une adresse IP du même réseau que l'hôte.
			3. **Host-Only Networking**: Ce mode crée un réseau isolé où seules les machines virtuelles et l'hôte peuvent communiquer entre elles.
			4. **Internal Networking**: Les machines virtuelles peuvent communiquer entre elles sur un réseau interne sans accès à l'hôte ou à Internet.

		- **Conclusion**: VirtualBox est un outil puissant et flexible pour créer et gérer des environnements virtuels. Il permet d'exécuter plusieurs systèmes d'exploitation sur une seule machine physique, facilitant ainsi les tests, le développement et la gestion des infrastructures IT. En comprenant les concepts de base de la création et de la configuration des machines virtuelles, vous pouvez exploiter pleinement les capacités de VirtualBox pour répondre à vos besoins informatiques.


	  </details>	 


 	- <details>
		<summary>
			Partie 4 - DOCKER Part 1
		</summary>
 
		- **Introduction à Docker**: Docker est une plateforme open-source qui automatise le déploiement d'applications dans des conteneurs logiciels. Ces conteneurs sont des environnements légers et portables qui contiennent tout ce dont une application a besoin pour fonctionner : code, runtime, outils système, bibliothèques et paramètres.
		- **Historique et Évolution**: Docker a été initialement développé par une entreprise française sous le nom de DotCloud en 2013. Le projet a rapidement gagné en popularité grâce à sa simplicité d'utilisation et à sa capacité à isoler les applications de manière efficace. Docker a révolutionné la virtualisation des applications en introduisant un moyen plus léger et plus portable de déployer des applications comparé aux machines virtuelles traditionnelles.
  		- **Conteneurisation vs Virtualisation**: La virtualisation traditionnelle utilise des hyperviseurs pour créer des machines virtuelles (VM), chaque VM ayant son propre système d'exploitation, ce qui peut consommer beaucoup de ressources. En revanche, Docker utilise la conteneurisation, où les conteneurs partagent le même noyau du système d'exploitation hôte mais sont isolés les uns des autres.

			**Avantages de la conteneurisation**
 
			1. **Performance améliorée**: Les conteneurs sont plus légers et démarrent plus rapidement que les machines virtuelles.
			2. **Efficacité des ressources**: Les conteneurs consomment moins de CPU, de mémoire et de stockage.
			3. **Portabilité**: Les conteneurs peuvent être déployés facilement sur n'importe quel environnement qui supporte Docker.
			4. **Isolation**: Chaque conteneur fonctionne indépendamment, ce qui réduit les conflits entre les dépendances des applications.

		- **Fonctionnement de Docker**: Docker fonctionne grâce à deux composants principaux : Docker Engine et Docker Hub.
 
			**Docker Engine**
    			Docker Engine est le moteur de conteneurisation qui crée et gère les conteneurs. Il utilise les fonctionnalités du noyau Linux, telles que les cgroups et les namespaces, pour isoler les conteneurs et contrôler leurs ressources.

			**Docker Hub**
			Docker Hub est un registre public où les développeurs peuvent partager et distribuer des images Docker. Il permet de stocker et de récupérer des images Docker, facilitant ainsi la distribution et le déploiement des applications.

		- **Création et Gestion des Conteneurs**
 
			1. **Dockerfile**: Les développeurs définissent les dépendances et les instructions de configuration pour leur application dans un fichier nommé Dockerfile. Ce fichier contient toutes les commandes nécessaires pour assembler une image Docker.
			2. **Construction de l'image**: À partir du Dockerfile, une image Docker est construite en utilisant la commande docker build. Cette image contient tout ce dont l'application a besoin pour fonctionner.
			3. **Exécution du conteneur**: Une fois l'image construite, elle peut être exécutée en tant que conteneur avec la commande docker run. Chaque conteneur est une instance en cours d'exécution de l'image.

		- **Déploiement des Applications avec Docker**
			1. **Création de l'image**: Le développeur crée une image Docker à partir du Dockerfile.
			2. **Publication de l'image**: L'image est poussée sur Docker Hub ou un registre privé en utilisant `docker push`.
			3. **Téléchargement de l'image**: L'image est téléchargée sur la machine hôte avec `docker pull`.
			4. **Exécution de l'image**: L'image est exécutée en tant que conteneur avec `docker run`.

		- **Comparaison entre les Machines Virtuelles et les Conteneurs**

			| Aspect	 | Machines Virtuelles	 | Conteneurs Docker |
			| :---------- | :----------- | :----------- |
			| **Démarrage**      |   Lent    |        Rapide |
			| **Consommation de Ressources** |	Élevée |	Faible |
			| **Isolation** |	Complète (niveau OS) |	Processus isolés (partage du noyau) |
			| **Portabilité** |	Moins portable (dépend du hyperviseur) |	Très portable (indépendant de l'OS) |
			| **Gestion des Dépendances** |	Complexe |	Simplifiée (tout inclus dans l'image) |

		- **Conclusion**: Docker est une technologie puissante qui simplifie le déploiement, la gestion et la portabilité des applications. En utilisant des conteneurs, les développeurs et les administrateurs système peuvent créer des environnements isolés pour chaque application, améliorant ainsi les performances, l'efficacité des ressources et la portabilité. Docker continue de jouer un rôle crucial dans l'évolution des infrastructures IT modernes, particulièrement dans les environnements cloud et DevOps.

	  </details>


 	- <details>
		<summary>
			Partie 5 - DOCKER Partie 2
		</summary>
 
		## Article éducatif : Installation de Docker sur une machine virtuelle Ubuntu

		### Introduction
		Docker est une plateforme logicielle qui permet de créer, tester et déployer des applications dans des conteneurs, des environnements isolés légers et portables. Dans cet article, nous verrons comment installer Docker sur une machine virtuelle (VM) Ubuntu, en utilisant un serveur sans interface graphique (desktop), ainsi que les configurations réseau nécessaires pour une utilisation optimale.

		### Préparation de l'environnement
		#### Choix du système d'exploitation
		Il est recommandé d'installer Docker sur un système d'exploitation serveur comme **Ubuntu Server**. Contrairement aux versions "desktop" d'Ubuntu, les versions serveur sont optimisées pour des performances et une gestion des ressources plus efficaces, sans l'utilisation d'une interface graphique lourde.

		#### Vérification des versions
		Avant d'installer Docker, il est important de vérifier que votre version d'Ubuntu est compatible. Docker nécessite au minimum **Ubuntu 18.04** ou supérieur. Les anciennes versions comme Ubuntu 16.04 ne sont pas supportées.

		### Installation de Docker
		#### Documentation officielle
		La documentation officielle de Docker fournit toutes les étapes nécessaires pour l’installation. Vous pouvez y accéder sur [docs.docker.com](https://docs.docker.com). Assurez-vous de choisir le bon système d’exploitation et de respecter les prérequis en termes de versions et de configuration système.

		#### Étapes d'installation
		1. **Mettre à jour le système** : Avant d'installer Docker, assurez-vous que votre système est à jour en exécutant les commandes suivantes :
		```bash
		sudo apt-get update
		sudo apt-get upgrade
		```

		2. **Installer Docker** : Utilisez ensuite les commandes suivantes pour installer Docker :
		```bash
		sudo apt-get install docker.io
		```

		3. **Vérifier l'installation** : Une fois installé, vérifiez que Docker fonctionne correctement avec la commande :
		```bash
		sudo systemctl status docker
		```

		### Configuration réseau de la machine virtuelle
		#### Mode NAT par défaut
		Lorsque vous configurez une machine virtuelle, VirtualBox utilise le mode NAT (Network Address Translation) par défaut. Ce mode permet à votre machine virtuelle d'accéder à Internet via l'interface réseau de la machine hôte, sans être directement accessible depuis l'extérieur. Cela améliore la sécurité, mais limite les interactions entre les machines virtuelles.

		#### Ajout d'une seconde interface réseau
		Pour créer un réseau privé entre plusieurs machines virtuelles, vous pouvez ajouter une seconde interface réseau en mode "réseau interne" (Internal Network). Cela permet aux machines de communiquer entre elles tout en restant isolées du réseau externe.

		1. **Configurer une interface réseau privée** : Dans VirtualBox, vous pouvez ajouter une interface privée en suivant ces étapes :
		- Ouvrez les paramètres de la VM.
		- Dans l'onglet Réseau, activez l’option "Adaptateur réseau interne".
		- Assurez-vous que les machines virtuelles partagent le même réseau interne en spécifiant le même nom de réseau pour toutes.

		2. **Vérification des adresses IP** : Utilisez la commande suivante pour vérifier l’adresse IP de la machine virtuelle :
		```bash
		ip addr show
		```

		3. **Ping entre machines** : Une fois le réseau privé configuré, vous pouvez tester la connectivité entre les machines virtuelles avec la commande `ping` :
		```bash
		ping 192.168.x.x
		```

		### Accès à distance via SSH
		#### Installation du serveur SSH
		Pour accéder à votre machine virtuelle Ubuntu depuis la machine hôte, vous devez installer et configurer le serveur SSH. Sur une version serveur d'Ubuntu, SSH est souvent installé par défaut. Cependant, si vous utilisez une version desktop, vous devrez l'installer manuellement :
		```bash
		sudo apt-get install openssh-server
		```

		#### Connexion via SSH
		Une fois SSH installé, vous pouvez vous connecter à la machine virtuelle depuis votre machine hôte en utilisant un client SSH (comme PuTTY sous Windows) :
		```bash
		ssh user@192.168.x.x
		```
		Remplacez `user` par votre nom d’utilisateur et `192.168.x.x` par l’adresse IP de votre machine virtuelle.

		### Conclusion
		L’installation de Docker sur une machine virtuelle Ubuntu est une étape clé pour développer dans un environnement isolé et contrôlé. En configurant correctement les réseaux et en utilisant des connexions SSH pour l’administration, vous pouvez créer des environnements flexibles et sécurisés pour tester et déployer vos applications Docker.

	  </details>

 	- <details>
		<summary>
			Partie 5 - DOCKER Partie 2
		</summary>

		## Article éducatif : Installation et Gestion de Docker

		### Introduction
		Docker est une plateforme populaire qui permet de créer, tester et déployer des applications dans des environnements isolés appelés conteneurs. Ces conteneurs sont légers, portables, et permettent d'exécuter des applications avec toutes leurs dépendances dans n'importe quel environnement. Dans cet article, nous allons explorer comment installer Docker sur un serveur Ubuntu, télécharger et gérer des images Docker, et comment utiliser des commandes clés comme `docker exec` pour interagir avec les conteneurs.

		### Installation de Docker sur Ubuntu
		#### Prérequis
		Avant de commencer l’installation de Docker, il est important de s’assurer que votre système d'exploitation est compatible. Docker exige au minimum **Ubuntu 18.04** ou une version plus récente pour fonctionner correctement. Vous pouvez vérifier la version de votre système en utilisant la commande suivante :
		```bash
		lsb_release -a
		```

		#### Installation via un script
		Pour simplifier l'installation, Docker fournit un script qui télécharge et installe Docker automatiquement. Cela évite les étapes manuelles complexes. Vous pouvez exécuter le script avec la commande suivante :
		```bash
		curl -fsSL https://get.docker.com -o get-docker.sh
		sudo sh get-docker.sh
		```
		Ce script va s'occuper de toutes les dépendances nécessaires et installer Docker sur votre machine.

		#### Vérification de l'installation
		Après l'installation, vous pouvez vérifier que Docker fonctionne correctement en exécutant la commande suivante :
		```bash
		docker --version
		```
		Cela devrait afficher la version de Docker installée sur votre système.

		### Gestion des images Docker
		Une des forces de Docker est la capacité à télécharger et exécuter des images prêtes à l'emploi pour diverses applications. Une image Docker est un modèle pré-construit contenant une application et toutes ses dépendances.

		#### Téléchargement d'une image Docker
		Par exemple, pour télécharger une image de **MySQL** ou **Nginx**, vous pouvez utiliser la commande suivante :
		```bash
		docker pull mysql
		```
		Cette commande télécharge l'image de MySQL depuis le **Docker Hub**, un dépôt d'images Docker.

		#### Exécution d'un conteneur
		Après avoir téléchargé une image, vous pouvez l'exécuter en créant un conteneur. Par exemple, pour démarrer un serveur Nginx, vous utilisez la commande suivante :
		```bash
		docker run -d -p 8080:80 nginx
		```
		Cette commande lance Nginx dans un conteneur en mode détaché (`-d`), et mappe le port interne 80 du conteneur au port externe 8080 de la machine hôte (`-p 8080:80`). Vous pouvez ensuite accéder au serveur Nginx en visitant `http://localhost:8080` dans votre navigateur.

		### Interagir avec des conteneurs : La commande `docker exec`
		#### Mode interactif
		Parfois, vous devez exécuter des commandes à l'intérieur d'un conteneur pour le configurer ou le déboguer. Cela est possible avec la commande `docker exec`. Par exemple, pour entrer dans un conteneur MySQL en cours d'exécution, vous pouvez utiliser :
		```bash
		docker exec -it <container_id> bash
		```
		L'option `-it` permet d'ouvrir une session interactive dans le terminal à l'intérieur du conteneur, ce qui est utile pour exécuter des commandes directement dans l'environnement du conteneur.

		#### Exécution de commandes spécifiques
		Vous pouvez également exécuter des commandes spécifiques à l'intérieur du conteneur sans ouvrir une session interactive. Par exemple, pour vérifier la version de MySQL dans un conteneur MySQL en cours d'exécution, utilisez :
		```bash
		docker exec <container_id> mysql --version
		```

		### Mapping des ports entre conteneurs et la machine hôte
		#### Importance du mapping des ports
		Lorsque vous exécutez une application dans un conteneur, celle-ci est isolée du réseau externe. Pour accéder à cette application depuis l'extérieur du conteneur (par exemple, via un navigateur ou une autre machine), il est nécessaire de mapper les ports internes du conteneur aux ports externes de la machine hôte. 

		#### Exemple de mapping avec Nginx
		Prenons l'exemple de l'exécution de Nginx dans un conteneur. Par défaut, Nginx utilise le port 80 à l'intérieur du conteneur. Cependant, pour rendre ce port accessible depuis l'extérieur, vous devez le mapper à un port de la machine hôte. Voici un exemple de commande pour mapper le port 80 interne du conteneur au port 8080 de la machine hôte :
		```bash
		docker run -d -p 8080:80 nginx
		```
		Vous pouvez ensuite accéder à Nginx en entrant l'adresse suivante dans un navigateur : `http://localhost:8080`.

		### Conclusion
		Docker facilite l'installation, la gestion et l'exécution d'applications en conteneur. Grâce à ses commandes simples, comme `docker pull` pour télécharger des images et `docker run` pour exécuter des conteneurs, Docker simplifie la gestion des applications. De plus, avec des commandes comme `docker exec` pour interagir directement avec les conteneurs, Docker offre une flexibilité exceptionnelle aux développeurs. Le mapping des ports est également crucial pour rendre les services accessibles à l'extérieur du conteneur, rendant Docker très puissant pour le développement et le déploiement d'applications.	
	
	 </details>


