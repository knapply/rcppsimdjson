% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{.deserialize_json}
\alias{.deserialize_json}
\alias{.load_json}
\title{Deserialize JSON into R Objects}
\usage{
.deserialize_json(
  json,
  json_pointer = "",
  empty_array = NULL,
  empty_object = NULL,
  simplify_to = 0L,
  type_policy = 0L,
  int64_r_type = 0L
)

.load_json(
  file_path,
  json_pointer = "",
  empty_array = NULL,
  empty_object = NULL,
  simplify_to = 0L,
  type_policy = 0L,
  int64_r_type = 0L
)
}
\arguments{
\item{json}{\code{character()} containing one or more strings of JSON data.}

\item{json_pointer}{\code{character(1L)}, default: \code{""}}

\item{empty_array}{default: \code{NULL}. Any R object to return for empty JSON arrays.}

\item{empty_object}{default: \code{NULL}. Any R object to return for empty JSON objects.}

\item{simplify_to}{\code{integer(1L)}, default: \code{0L}.
Maximum simplification level.
0: data frame, 1: matrix, 2: vector, 3: list (no simplification)}

\item{type_policy}{\code{integer(1L)}, default: \code{0L}.
Level of type strictness.
0: merge everything, 1: merge numbers, 2: strict (mixed types are not merged)}

\item{int64_r_type}{\code{integer(1L)} default: \code{0L}
How to return big integers to R.
0: \code{double}, 1: string, 2: \code{bit64::integer64}-compatible number}

\item{file_path}{\code{character()} containing one or more paths to files containing
JSON data.}
}
\description{
Deserialize JSON into R Objects
}
\details{
Instead of using \code{lapply()} for vectors containing multiple strings/file paths,
    just use \code{.deserialize_json()} and \code{.load_json()} directly as they are vectorized
    (in the R sense). This is much more efficient as the underlying \code{simdjson::parser} can
    reuse internal buffers between parses. Since the overwhelming majority of JSON objects
    parsed will not result in R scalars, a \code{list()} is always returned when multiple items
    are passed to \code{.deserialize_json()} or \code{.load_json()}. Also in keeping with
    \code{lapply()}'s behavior, if the data passed has \code{names()}, the returned object will
    have the same names.
}
\examples{
# .deserialize_json() ======================================================
RcppSimdJson:::.deserialize_json('[[1,2,3],[4,5,6]]')

RcppSimdJson:::.deserialize_json(
  '[{"a":1,"b":true},{"a":2,"b":false,"c":null}]'
)

RcppSimdJson:::.deserialize_json(
  c(
    json1 = "[[1,2,3],[4,5,6]]",
    json2 = '[{"a":1,"b":true},{"a":2,"b":false,"c":null}]'
  )
)

# .load_json() =============================================================
single_file <- system.file("jsonexamples", "small", "flatadversarial.json",
                           package = "RcppSimdJson")
RcppSimdJson:::.load_json(single_file)

multiple_files <- vapply(
  c("flatadversarial.json", "adversarial.json"),
  function(.x) {
    system.file("jsonexamples/small", .x, package = "RcppSimdJson")
  },
  character(1L)
)
RcppSimdJson:::.load_json(multiple_files)

}
\keyword{internal}
