# Inception

## Project Overview

- **Objective:** The main goal of this project is to have you set up a small infrastructure composed of various services running inside Docker containers. This infrastructure will simulate a real-world environment where different services interact with each other within a virtualized environment.

- **Key Components:**
	1. **Virtual Machine:** The entire project must be executed within a Virtual Machine (VM). This ensures that the environment is controlled and isolated from the host system.
	2. **Docker Containers:**
		- You will be creating multiple Docker containers, each dedicated to a specific service.
		- **Services Required:**
			- **NGINX** with TLSv1.2 or TLSv1.3
			- **WordPress** with php-fpm (without NGINX)
			- **MariaDB (a popular database system)**
		- Each service must have its Dockerfile, and the Docker images must be built by you using Docker Compose. It is forbidden to use pre-built images from sources like DockerHub (with the exception of Alpine or Debian as base images).
	3. **Volumes and Networking:**
		- You will set up Docker volumes to persist data, particularly for the WordPress database and website files.
		- A custom Docker network must be created to allow the containers to communicate with each other securely.
	4. **Domain Configuration:**
		- You must configure a domain name that points to your local IP address. This domain will be in the format `login.42.fr`, where "login" is your own username.
	5. **Security and Best Practices:**
		- Environment variables must be used for sensitive data such as passwords, which should be stored in a `.env` file.
		- The NGINX container should be the only entry point to your infrastructure, serving traffic over HTTPS via port 443.

- **Bonus Objectives:**
	- If you successfully complete the mandatory tasks perfectly, you can also add extra services as part of a bonus. These can include setting up:
		- A Redis cache for WordPress.
		- An FTP server.
		- A simple static website (excluding PHP).
		- Adminer, a database management tool.
		- Any other service you deem useful, provided you can justify its inclusion.
- **Conclusion**:
This project is designed to push your understanding of system administration and Docker. It requires a strong grasp of Docker best practices, an understanding of network configuration, and careful management of environment variables and sensitive data. The project mimics the complexities of a real-world deployment scenario, ensuring that by the end, you have hands-on experience in managing and deploying containerized applications.


## Prerequisites and Explanations

### Deep Dive into Containers

#### What is a Container?

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

#### How Containers Differ from Virtual Machines

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



#### Key Concepts in Containers
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

3. **Pivot Root:**
	- Pivot Root is a Linux kernel feature that allows a process to change its root filesystem. This is used in containers to isolate the filesystem of the container from the host system.

		![pivot-root](https://github.com/user-attachments/assets/4e9d3619-87d9-43ea-9bad-9ac6ad32a842)


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
   		




## Tools

- [https://labs.play-with-docker.com/](https://labs.play-with-docker.com/) :  



## Resources

- [ Youtube - Professeur Mohamed YOUSSFI - Virtualisation et Containérisation : VirtualBox DOCKER KUBERNETES](https://youtube.com/playlist?list=PLxr551TUsmApVwBMzhtLqrWqcKQs4sh19&si=W0Y5nBVF4gC4Hi5k)
 	- <details>
		<summary>
			Part 1 Virtualisation et Containerisation Docker - Retour sur Architecture de Base des Ordinateurs
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
			Part 2 Virtualisation et Containerisation - Bases de la virtualisation
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
			Part 3 Virtualisation et Containerisation - Bases de Virtual Box
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
			Part 4 - DOCKER Part 1
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








		










	
