{{- $varNameSingular := .Table.Name | singular | camelCase -}}
{{- $tableNameSingular := .Table.Name | singular | titleCase -}}
var (
  {{$varNameSingular}}Columns                   = []string{{"{"}}{{.Table.Columns | columnNames | stringMap .StringFuncs.quoteWrap | join ", "}}{{"}"}}
  {{$varNameSingular}}ColumnsWithoutDefault     = []string{{"{"}}{{.Table.Columns | filterColumnsByDefault false | columnNames | stringMap .StringFuncs.quoteWrap | join ","}}{{"}"}}
  {{$varNameSingular}}ColumnsWithDefault        = []string{{"{"}}{{.Table.Columns | filterColumnsByDefault true | columnNames | stringMap .StringFuncs.quoteWrap | join ","}}{{"}"}}
  {{$varNameSingular}}ColumnsWithSimpleDefault  = []string{{"{"}}{{.Table.Columns | filterColumnsBySimpleDefault | columnNames | stringMap .StringFuncs.quoteWrap | join ", "}}{{"}"}}
  {{$varNameSingular}}ColumnsEnforced           = []string{{"{"}}{{.Table.Columns | filterColumnsByEnforced | columnNames | stringMap .StringFuncs.quoteWrap | join ", "}}{{"}"}}
  {{$varNameSingular}}PrimaryKeyColumns         = []string{{"{"}}{{.Table.PKey.Columns | stringMap .StringFuncs.quoteWrap | join ", "}}{{"}"}}
  {{$varNameSingular}}AutoIncrementColumns      = []string{{"{"}}{{.Table.Columns | filterColumnsByAutoIncrement true | columnNames | stringMap .StringFuncs.quoteWrap | join "," }}{{"}"}}
  {{$varNameSingular}}AutoIncPrimaryKey         = "{{- with autoIncPrimaryKey .Table.Columns .Table.PKey -}}{{.Name}}{{- end -}}"
)

type (
  {{$tableNameSingular}}Slice []*{{$tableNameSingular}}
  {{$tableNameSingular}}Hook func(*{{$tableNameSingular}}) error

  {{$varNameSingular}}Query struct {
    *boil.Query
  }
)
