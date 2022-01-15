(local util (require :vim.lsp.util))
(local nvim_definition (. vim.lsp.handlers :textDocument/definition))

(fn definition []
  (let [params (util.make_position_params)]
    (tset params :wantMetadata true)
    (vim.lsp.buf_request 0 :o#/gotodefinition params handleDefinition)))

(fn handleDefinition [err result ctx]
  (print "Handle Definition:")
  (print (vim.inspect err))
  (print (vim.inspect result))
  (print (vim.inspect ctx))
  (if (string.match result.uri "%%24metadata%%24")
    (let [client (vim.lsp.get_client_by_id ctx.client_id)
          params {:position {:character result.range.start.character
                              :line result.range.start.line}
                   :textDocument {:uri result.uri}}]
      (client.request "o#/metadata" params handleMetadata))
    (nvim_definition err result ctx)))

(fn handleMetadata [err result ctx]
  (print "Handle Metadata")
  (print (vim.inspect err))
  (print (vim.inspect result))
  (print (vim.inspect ctx)))

{:handlers {:o#/gotodefinition handleDefinition
            :o#/metadata handleMetadata}
 :methods {:definition definition}}
