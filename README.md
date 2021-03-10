# Syadem: Test Technique

## Pré-requis

Avoir Docker et Docker compose installés pour lancer l’application.

## Objectifs

Ce test ne devrait pas prendre plus de 3h à compléter.

Le but du test et de voir comment tu développes et les méthodologies que tu utilises, voici ce que l’on regarde:

- La fonctionnalité et l’efficacité (car on aime le code simple et qui fonctionne)
- La lisibilité du code (car on aime le code propre)
- Ce qui est testé et comment
- L’historique de commit pour voir l’évolution de la réflexion

## Description

A partir de l'application Rails déjà initialisée, créer un système pour vérifier qu’un profil est à jour ou non contre la maladie “Covid” (dans un soucis de garder ce test simple, on considère que le système ne traite que d’une maladie).

- Un profil possède une date de naissance.
- Un profil peut recevoir plusieurs injection du vaccin à une date donnée.

Voici les règles pour considérer qu'un profil est à jour de ses vaccins contre la maladie
Est à jour:

- Un enfant (moins de 14 ans) ayant reçu 2 doses à 6 mois d’intervalles
- Un adulte (entre 14 et 65 ans) ayant reçu 1 doses au cours des 36 derniers mois
- Une personne âgée (> 65 ans) ayant reçu 1 dose au cours des 12 derniers mois

Seul la partie fonctionnelle nous intéresse, donc pas la peine de créer des vues.

On doit pouvoir tester pour un profil donné si il est à jour ou non en console.

## Livrable

Un repo Git avec l’historique des commits.

Une application fonctionnel en console.

## Comment tester :

`bundle exec rspec spec/models/user_spec.rb` 

ou via la console :

```
    user = User.create(name: "John Doe", birthdate: "2000-01-01")
    user.verify
```
