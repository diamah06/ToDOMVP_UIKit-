Application To-Do List iOS avec Architecture MVP

Aperçu

Cette application iOS est une application de liste de tâches développée en utilisant le framework UIKit et suit le modèle d'architecture MVP (Model-View-Presenter) recommandé par Apple. L'application intègre les méthodes HTTP REST : GET, POST, PUT et DELETE pour gérer les tâches.

Architecture MVP

L'architecture MVP divise l'application en trois composants principaux :

- Modèle : Représente les données et la logique métier de l'application. Il gère des tâches telles que la récupération, la mise à jour, la création et la suppression des tâches à partir d'une source de données.
- Vue : Représente les composants de l'interface utilisateur de l'application. Elle est responsable de l'affichage des données à l'utilisateur et de la saisie utilisateur.
- Présentateur : Fait office d'intermédiaire entre le modèle et la vue. Il récupère les données du modèle, les traite, puis met à jour la vue en conséquence. Il gère également les interactions utilisateur et délègue les tâches au modèle.
  
Fonctionnalités

- Créer, Lire, Mettre à jour et Supprimer (CRUD) des tâches.
- Afficher une liste de tâches. 
- Permettre aux utilisateurs d'ajouter de nouvelles tâches, de marquer des tâches comme terminées, de modifier des tâches existantes et de supprimer des tâches.
