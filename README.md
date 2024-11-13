# terraform-aws-emr-spark-6.3
template terraform pour la création d'un cluster emr 6.3
<<<<<<< HEAD

=======
Prérequis:
-terraform
-aws cli

Configuration AWS
Créer un profil AWS : 
Utilisez la commande aws configure pour configurer vos informations d'identification AWS. Si vous avez déjà configuré AWS CLI, vous pouvez ignorer cette étape.
Autorisations IAM : 
Assurez-vous que votre profil AWS dispose des autorisations nécessaires pour créer des ressources EMR, telles que AmazonElasticMapReduceFullAccess.
Les autorisations peuvet-etre créer avec le template terraform ou manuellement sur aws.

Configuration du projet Terraform:
les commandes:
  -Dans le répertoire racine du projet, exécutez la commande suivante pour initialiser Terraform: terraform init
  -Exécutez la commande suivante pour vérifier le plan d'exécution de Terraform: terraform plan
  -Une fois satisfait du plan Terraform, déployez le cluster EMR en exécutant la commande suivante :terraform apply 


Accès au cluster EMR
Une fois le déploiement terminé, vous pouvez accéder au cluster EMR via l'interface AWS Management Console ou en utilisant l'AWS CLI.

Pour accéder à l'interface Web EMR, recherchez votre cluster dans la console AWS EMR et cliquez sur son nom pour accéder à la page de détails.

Pour accéder au cluster via l'AWS CLI, utilisez la commande aws emr ssh en spécifiant l'ID du cluster.

!! Bien faire attention lors de la création du cluster afin d'avoir accès a la clé ssh pour ce connecter aux instances du cluster. Sinon les instances ne seront pas accessibles.!!

N'oubliez pas de détruire les ressources une fois que vous avez terminé pour éviter des frais inutiles : terraform destroy.
Si vous rencontrez des problèmes ou avez des questions, n'hésitez pas à consulter la documentation Terraform et AWS ou à demander de l'aide dans les forums de la communauté. 
>>>>>>> 03e42b3da0c8fc71dfce0ab8e18aae32497f14ee
