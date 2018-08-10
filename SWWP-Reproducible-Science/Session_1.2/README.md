# What is Git and GitHub?

The short answer: Git is version control. (*Git was originally designed as a collaborative tool for big software projects*)

A good article about version control by Jennifer Bryan can be found [here](https://peerj.com/preprints/3159/).

If you're anything like me, you tend to generate a large number of datasets, spreadsheets, text files, scripts, figures and photos, and these often are integral to statistical analysis. Sometimes it can be difficult to relocate specific datasets or analysis scripts and if you're collaborating with others (and as Jennifer Bryan points out in her article that includes **future you**), this can turn into very serious problem.

In terms of reproducibility in science it is crucial that a system is in place to handle the quality and integrity of your data through time. This is where GitHub comes in. GitHub is used to record changes in files over time.

### GitHub is an online host for Git projects:
GitHub provides an interface to interact with your Git projects.

* **Organized**
* **Structured**
* **Integrative**


## Talking with Git
Let's go ahead and make sure that we can talk with Git.
If you have a windows machine open up your `Git Shell`

We're going to adjust the global properties so that Git recognizes us.

1. `git config --global user.name 'your name here'`
2. `git config --global user.email 'your email here'`
3. `git config --global --list`

## Creating a repository
So let's jump right in. We can go ahead and use our Rmarkdown project from the last session as an example.

1. You should have created a GitHub account alread, so go ahead and [sign on](https://github.com/)
2. In the top right corner of your screen next to your profile `click` the plus button
3. Choose `New repository`
4. Now give your repository a meaningful name
5. You can choose to have your repository public or private
6. `Check` the box that says *initialize this repository with a README* - This will eventually be filled with information for anyone who is going to use this repository
7. Last `select` the dropdown menu that say *add a license* and `select` *MIT license*  - There's a good discussion about the different types of licenses [here](http://www.astrobetter.com/blog/2014/03/10/the-whys-and-hows-of-licensing-scientific-code/)
8. `Click` the green *create repository* button

There! Now you have a new repository that is initialized with a readme file and an open source license.

## Clone the new GitHub repository to your computer via Git

1. Open your Git Shell
2. `git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git`
3. Make your repository the working director `cd yourdirectory`
4. Explore the contents `ls` `head README.md` `git remote show origin`
5. Make an edit to your `README.md` file `echo "Write something meaningful about your project" >> README.md
6. `git status`

## Commit changes to your project
1. `git add -A`

2. `git commit -m "you must comment your commit"`

3. `git push` This pushes your changes back to your GitHub Account

Now you can go back to your GitHub account and verify that the changes have occurred.

#Working with a Git Client and Rstudio

There are several different Git Cliants available and some are better than others. GitHub suggests GitHub Desktop and that's what we'll be working with today. However I am not endorsing any specific cliant and you should explore other if you want.

Also, if you follow the instruction in Jennifer Bryan's book in [chapter 13](https://happygitwithr.com/rstudio-git-github.html) you can set `Rstudio` up to directly push and pull from GitHub.

Go ahead and open `GitHub Desktop`

What we're going to do now is basically the same thing we did in the Git Shell but we're going to work on our project from session 1 this morning.

1. In the file menu select `Add local repository`
2. Give it a meaningful Name
3. Check `initialize this repository with a README`
4. Select the `MIT License`
5. Click `Create repository`

Now we have to push it to GitHub
1. Click `Publish repository`
  * You can choose to keep the repository public or private and give it a meaningful description

Check your GitHub account and make sure that the repository was created and was initialized with a README.md

Now we can save our `Rmarkdown` project to our new repository.

1. Open up `Rstudio` and your `Rmarkdown` from the first session
2. Save your `Rmarkdown` file to your repository folder in the `GitHub` directory of your local machine.
3. Go to `GitHub Desktop` and check that your changes are represented.

No we need to commit the changes.

1. Add a summary commit comment
2. Add a description
3. Click Commit to master

Lastly, you need to **Push to origin** on GitHub

And that's it. As you work on your project in Rstudio you can periodically commit changes and push to `GitHub`. This allows you to clone the project to multiple computers, invite collaborators and manage changes and versions of your project. You can fetch, push and pull.

This is the basics, and there are many other tools and skills that can improve your data management and reproducibility.
