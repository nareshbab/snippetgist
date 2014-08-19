config.options <- function() list(github.api.url="http://127.0.0.1:7990/rest/snippets/1.0/snippets", github.base.url="http://127.0.0.1:7990/", github.client.id=TRUE, github.client.secret=TRUE)

create.gist.context <- function(username, token, github.api.url, github.client.id, github.client.secret, github.base.url, ...) {
  if (is.character(token) && !isTRUE(nzchar(token))) token <- NULL ## github requires token to be NULL if not used
  ctx <- Rstash::create.github.context(api_url=github.api.url, client_id=github.client.id, client_secret=github.client.secret, access_token=token)
  ctx$github.base.url=github.base.url
  str(ctx)
  ctx
}

auth.url.snippetcontext <- function(redirect, ctx) {
  state <- list(nonce=rnorm(1), redirect=as.vector(redirect))
  vals <- authenticate.sni(ctx$client_id, ctx$client_secret, ctx$github.base.url)
  paste0(ctx$github.base.url,
         "plugins/servlet/oauth/authorize?oauth_token=", vals["oauth_token"],
         "&state=",URLencode(toJSON(state), TRUE),
         "&scope=gist,user:email")
}

get.gist.snippetcontext <- Rstash::get.gist

fork.gist.snippetcontext <- Rstash::fork.gist

modify.gist.snippetcontext <- Rstash::modify.gist

create.gist.snippetcontext <- Rstash::create.gist

delete.gist.snippetcontext <- Rstash::delete.gist

modify.gist.snippetcontext <- Rstash::modify.gist

create.gist.comment.snippetcontext <- Rstash::create.gist.comment

get.gist.comments.snippetcontext <- Rstash::get.gist.comments