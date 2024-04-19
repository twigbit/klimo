/// Prepares rich text content from Airtable for consumption by the flutter_markdown package.
///
/// It performs the following transformations:
/// - Un-escapes markdown image tags
///
/// Future enhancements:
/// - Airtable returns a single newline for paragraphs, but the Markdown-spec
///   requires two
/// - Airtable is less strict, when rendering inline styles (bold, italic, ...)
///   For example, sometimes Airtable returns the following markdown which is
///   rendered as bold inside Airtable but is not by flutter_markdown:
///   `**this should be bold **` (Note the space before the closing `**`)
String preprocessAirtableMarkdown(String input) {
  final imageUnEscaping = RegExp(r'!\\\[([^\]]*)\]\\\(([^)]*)\)');
  return input.replaceAllMapped(
      imageUnEscaping, (match) => "![${match[1]}](${match[2]})");
}
