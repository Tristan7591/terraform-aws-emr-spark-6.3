# terraform-aws-emr-spark-6.3
template terraform pour la création d'un cluster emr 6.3
Ce guide explique comment utiliser Terraform et AWS pour déployer un cluster EMR (Elastic MapReduce) avec Spark intégré. Vous aurez besoin de Terraform installé sur votre machine locale et d'un compte AWS avec les autorisations nécessaires pour créer des ressources.

Prérequis
Assurez-vous d'avoir les éléments suivants installés sur votre machine :

Terraform
AWS CLI
Visual Studio Code (ou tout autre éditeur de texte de votre choix)
Configuration AWS
Créer un profil AWS : Utilisez la commande aws configure pour configurer vos informations d'identification AWS. Si vous avez déjà configuré AWS CLI, vous pouvez ignorer cette étape.
Autorisations IAM : Assurez-vous que votre profil AWS dispose des autorisations nécessaires pour créer des ressources EMR, telles que AmazonElasticMapReduceFullAccess.
Configuration du projet Terraform
Cloner le référentiel : Clonez ce référentiel sur votre machine locale.
bash
Copy code
git clone https://github.com/votre-utilisateur/votre-repo.git
Configuration des variables Terraform : Modifiez le fichier variables.tf pour spécifier les valeurs des variables telles que region, cluster_name, instance_type, etc., selon vos besoins.
Initialisation Terraform : Dans le répertoire racine du projet, exécutez la commande suivante pour initialiser Terraform :
bash
Copy code
terraform init
Vérification du plan Terraform : Exécutez la commande suivante pour vérifier le plan d'exécution de Terraform :
bash
Copy code
terraform plan
Déploiement du cluster EMR : Une fois satisfait du plan Terraform, déployez le cluster EMR en exécutant la commande suivante :
bash
Copy code
terraform apply
Confirmation : Terraform vous demandera de confirmer le déploiement. Entrez yes pour continuer.
Accès au cluster EMR
Une fois le déploiement terminé, vous pouvez accéder au cluster EMR via l'interface AWS Management Console ou en utilisant l'AWS CLI.

Pour accéder à l'interface Web EMR, recherchez votre cluster dans la console AWS EMR et cliquez sur son nom pour accéder à la page de détails.

Pour accéder au cluster via l'AWS CLI, utilisez la commande aws emr ssh en spécifiant l'ID du cluster.

Nettoyage
N'oubliez pas de détruire les ressources une fois que vous avez terminé pour éviter des frais inutiles :

bash
Copy code
terraform destroy
Confirmez la destruction en saisissant yes lorsque vous y êtes invité.

N'oubliez pas de personnaliser ce README en fonction de votre environnement, de vos préférences et de vos besoins spécifiques. Si vous rencontrez des problèmes ou avez des questions, n'hésitez pas à consulter la documentation Terraform et AWS ou à demander de l'aide dans les forums de la communauté. Bonne exploration avec EMR !
