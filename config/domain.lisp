(in-package :mu-cl-resources)

;;;; define the resource

(define-resource pipeline ()
  :class (s-prefix "pwo:Workflow")
  :resource-base (s-url "http://www.big-data-europe.eu/data/workflows/")
  :properties `((:title :string ,(s-prefix "dcterms:title"))
                (:description :string ,(s-prefix "dcterms:description")))
  :has-many `((step :via ,(s-prefix "pwo:hasStep")
                    :as "steps"))
  :on-path "pipelines")

(define-resource step ()
  :class (s-prefix "pwo:Step")
  :resource-base (s-url "http://www.big-data-europe.eu/data/steps/")
  :properties `((:title :string ,(s-prefix "dcterms:title"))
                (:description :string ,(s-prefix "dcterms:description"))
		(:code :string ,(s-prefix "pip:code"))
                (:order :number ,(s-prefix "pip:order"))
                (:status :string ,(s-prefix "pip:status")))
  :has-one `((pipeline :via ,(s-prefix "pwo:hasStep")
                       :inverse t
                       :as "pipeline"))
  :on-path "steps")
