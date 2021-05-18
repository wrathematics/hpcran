# hpcran

Web content and utils for https://hpcran.org. In theory this could be used to create your own R package archive network.

On the backend, updating looks something like this:

```
cd /hpcran
git pull origin master # this repository
cd backend

R CMD INSTALL r
sudo R CMD INSTALL r

sudo -u www-data Rscript -e "hpcran::regenerate()"
```

The approved users are stored in a sqlite database at `/hpcran/backend/uploaders.db`. See the scripts in `backend/db` of this repository for how it works.
