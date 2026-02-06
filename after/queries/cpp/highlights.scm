; extends

((system_lib_string) @string.special.path
  (#set! priority 110))

; Keep fully-qualified namespace values like std::cout in module color.
((qualified_identifier
  name: (identifier) @module)
  (#not-has-ancestor? @module call_expression function_declarator)
  (#set! priority 110))

((qualified_identifier
  (identifier) @module)
  (#not-has-ancestor? @module call_expression function_declarator)
  (#set! priority 110))

; Match the scope operator itself inside qualified identifiers.
(("::" @module)
  (#has-ancestor? @module qualified_identifier)
  (#set! priority 110))
