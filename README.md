# Inception


## Introduction

This repository is a collection of notes, code snippets, and other resources that I have gathered over time. It is a work in progress and will be updated as I learn new things.

## Table of Contents



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
