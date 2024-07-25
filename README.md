# Inception


## Introduction

This repository is a collection of notes, code snippets, and other resources that I have gathered over time. It is a work in progress and will be updated as I learn new things.

## Table of Contents

## KodeKloud Courses

### learning Paths: Docker
#### DevOps Pre-Requisites Course

<details>
<summary>Curriculum
</summary>

- [x] 1. **Linux Basics**
	- [ ] 1.1 Linux CLI
	- [ ] 1.2 VI Editor
	- [ ] 1.3 Package Management
	- [ ] 1.4 Service Management
- [ ] 2. **Setup Lab Environment**
	- [ ] 1.1 Setup Labs - Laptop or cloud
	- [ ] 1.2 VirtualBox
		- [ ] 1.2.1 Deploying VMs
		- [ ] 1.2.2 Multiple VMS
		- [ ] 1.2.3 Networking and Troubleshooting Network
		- [ ] 1.2.4 Snapshots
	- [ ] 1.3 Vagrant
- [ ] 3. Linux Networking Basics
	- [ ] 1.1 Interfaces
	- [ ] 1.2 IP Addressing
	- [ ] 1.3 Routing
	- [ ] 1.4 DNS
- [ ] 4. SCM Basics (GIT)
	- [ ] 1.1 nstall GIT
	- [ ] 1.2 Git Repository
	- [ ] 1.3 Clone source code with GIT
	- [ ] 1.4 Make and commit changes
	- [ ] 1.5 Push source code
- [ ] 5. Application Basics
	- [ ] 1.1 Who is this for?
		- [ ] 1.1.1 Non-Developers
	- [ ] 1.2 Different types of applications
		- [ ] 1.2.1 Python
		- [ ] 1.2.2 Java
		- [ ] 1.2.3 NodeJS
	- [ ] 1.3 Building
	- [ ] 1.4 Troubleshooting
	- [ ] 1.5 Labs
- [ ] 6. Web Servers
	- [ ] 1.1 Web Frameworks
	- [ ] 1.2 Web Servers
	- [ ] 1.3 Apache HTTPD
	- [ ] 1.4 Nginx
	- [ ] 1.5 Python - Gunicorn
	- [ ] 1.6 NodeJS - 
	- [ ] 1.7 IPs and Ports
	- [ ] 1.8 SSL and Certificates
- [ ] 7. Databases
	- [ ] 1.1 Who is this for?
		- [ ] 1.1.1 Non-Developers
	- [ ] 1.2 Different types of databases
		- [ ] 1.2.1 MySQL
		- [ ] 1.2.2 PostgreSQL
		- [ ] 1.2.3 MongoDB
	- [ ] 1.3 Web Servers
- [ ] 8. Multi-Tier Applications
- [ ] 9. JSON/YAML

</details>


## Resources

- **Youtube**:
- [Professeur Mohamed YOUSSFI - Virtualisation et Containérisation : VirtualBox DOCKER KUBERNETES](https://youtube.com/playlist?list=PLxr551TUsmApVwBMzhtLqrWqcKQs4sh19&si=W0Y5nBVF4gC4Hi5k)
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
