#!/usr/bin/perl

use FileHandle;
use Getopt::Std;
use XML::DOM;


sub print_usage {
  print("Usage:\n".
	"$0\n".
	"\t[-D]                  Specify Component Descriptor creation mode.\n".
	"\t                          In this mode the output will be a component\n".
	"\t                          description XML file.\n".
	"\t[-I]                  Specify Component Descriptor Import mode.\n".
	"\t                          In this mode the output descriptor will be the same\n".
	"\t                          as the input descriptor, but will have the specified import\n".
	"\t                          dist location added to the descriptor record.\n".
	"\t[-R]                  Specify Component Descriptor report mode (Not implemented yet).\n".
	"\t[-o <outfile>]        Specify the output file.\n".
	"\t[-f <infile>]         Specify the input file.\n".
	"\t[-c <component name>] Specify the name of the component\n".
	"\t[-r <component rev>]  Specify the revision of the component\n".
	"\t[-d <path>]           Specify the reference dist location of the component\n".
	"\t[-i <path>]           Specify the import dist location of the component\n".
	"\t[-a <comment>]        Specify a comment to put in the output descriptor\n".
	"\t[-p <platform>]       Specify the primary platform of the component\n".
	"\t[-v <vtag>]           Specify the variant tag of for the component\n".
	"\t[-m <platform list>]  Specify a space seperated list of compatibility\n".
	"\t                          platforms for the component\n".
	"\t[-l <import list>]    Specify a space seperated list of component descriptor files\n".
	"\t                          for components imported by the current component. These\n".
	"\t                          descriptors will be loaded and included in the \"Import\"\n".
	"\t                          element of the output descriptor.\n".
	"\t[-h]                  Display help message\n");
}


#
# Main
#

getopts('a:c:d:Df:hi:Il:m:o:p:P:r:Rv:');

if ($opt_D) {
  $mode='desc_creation';
}
if ($opt_R) {
  $mode='desc_report';
}
if ($opt_I) {
  $mode='desc_import';
}

if ($opt_h) {
  print_usage();
  exit 0;
}
$output_filename = $opt_o || '-';
$input_filename = $opt_f || '-';
$component_importdist = $opt_i;
$component_name = $opt_c || "NULL";
$component_rev = $opt_r || "-UNSPECIFIED-";
$component_platform = $opt_p || "noarch";
@component_compat_platforms = split(/\s+/, $opt_m);
@component_import_descs = split(/\s+/, $opt_l);
$component_refdist = $opt_d;
$component_comment = $opt_a;
$component_variant = $opt_v;

$exit_code = 0;




$output_fh = new FileHandle();
if ($output_filename eq '-') {
    $output_fh->fdopen(STDOUT, "w");
  }
else {
  $output_fh->open($output_filename, "w")
    || die "could not open file \"$output_filename\" for output";
}

if ($mode eq 'desc_creation') {

  $parser = XML::DOM::Parser->new();


  $desc_doc = XML::DOM::Document->new;
  $desc_docdecl = $desc_doc->createXMLDecl('1.0');

  $desc_cd = ComponentDesc_New($desc_doc);
  if ($component_name) {
    ComponentDesc_SetAttributeValue($desc_cd, "Name", $component_name);
  }
  if ($component_rev) {
    ComponentDesc_SetAttributeValue($desc_cd, "Revision", $component_rev);
  }
  if ($component_comment) {
    ComponentDesc_SetAttributeValue($desc_cd, "Comment", $component_comment);
  }
  if ($component_platform) {
    ComponentDesc_SetAttributeValue($desc_cd, "Platform", $component_platform);
  }
  if ($component_variant) {
    ComponentDesc_SetAttributeValue($desc_cd, "Variant", $component_variant);
  }
  if ($component_refdist) {
    ComponentDesc_SetAttributeValue($desc_cd, "ReferenceDist", $component_refdist);
  }
  if ($component_importdist) {
    ComponentDesc_SetAttributeValue($desc_cd, "ImportDist", $component_importdist);
  }
  foreach $cp (@component_compat_platforms) {
    ComponentDesc_AppendAttributeNode($desc_cd, 'CompatibilityPlatform' , $cp);
  }


  foreach $import_desc_file (@component_import_descs) {
    print("Importing component descriptor $import_desc_file\n");
    $import_doc = eval {$parser->parsefile($import_desc_file)};
    if ($import_doc) {
      foreach $import_node ($import_doc->getChildNodes) {
	if ($import_node->getNodeName eq "ComponentDesc") {
	  $import_cd = $import_node;
	  last;
	}
      }
      # ComponentDesc_Print($output_fh, $import_cd);
      $import_cd_clone = $import_cd->cloneNode(1);
      $import_cd_clone->setOwnerDocument($desc_doc);
      ComponentDesc_AppendImport($desc_cd, $import_cd_clone);
    }
    else {
      print("WARNING: Could not load component descriptor $import_desc_file".
	    " Imported component will not be mentioned in new component".
	    " descriptor's import chain.\n");
    }
  }


  XML_PrintDecl($output_fh, $desc_docdecl);
  print($output_fh "\n");
  ComponentDesc_MakePretty($desc_cd);
  ComponentDesc_Print($output_fh, $desc_cd);
  print($output_fh "\n");

}
elsif ($mode eq 'desc_report') {

  $parser = XML::DOM::Parser->new();
  $desc_doc = $parser->parsefile($input_filename);
  foreach $doc_node ($desc_doc->getChildNodes) {
    if ($doc_node->getNodeName eq "ComponentDesc") {
      $desc_cd = $doc_node;
      last;
    }
  }
  print($output_fh "\n");
  ComponentDesc_MakePretty($desc_cd);
  ComponentDesc_Print($output_fh, $desc_cd);
  print($output_fh "\n");


}
elsif ($mode eq 'desc_import') {
  $parser = XML::DOM::Parser->new();
  $desc_doc = $parser->parsefile($input_filename);
  foreach $doc_node ($desc_doc->getChildNodes) {
    if ($doc_node->getNodeName eq "ComponentDesc") {
      $desc_cd = $doc_node;
      last;
    }
  }


  if ($component_importdist) {
    ComponentDesc_SetAttributeValue($desc_cd, "ImportDist", $component_importdist);
  }

  $desc_docdecl = $desc_doc->getXMLDecl;
  XML_PrintDecl($output_fh, $desc_docdecl);
  print($output_fh "\n");
  ComponentDesc_MakePretty($desc_cd);
  ComponentDesc_Print($output_fh, $desc_cd);
  print($output_fh "\n");
}
else {
  print("No run mode was specified. Exiting.\n");
  print_usage();
  $exit_code = 1;
}


$output_fh->close();
exit ($exit_code);






sub XML_PrintDecl {
  local($fileh, $decl) = @_;

  print($fileh $decl->toString);
}

sub ComponentDesc_CompressWhiteSpace {
  local($element) = @_;
  local($node, $text);

  foreach $node ($element->getChildNodes) {
    if ($node->getNodeType == ELEMENT_NODE) {
      ComponentDesc_CompressWhiteSpace($node);
    }
    elsif ($node->getNodeType == TEXT_NODE) {
      $text = $node->getData;
      if ($node->getData !~ /[^\s\r\n]/gm) {
	$element->removeChild($node);
      }
      $text =~ s/^\s+//gm;
      $text =~ s/\s+$//gm;
      $node->setData($text);
    }
  }
}

sub ComponentDesc_MakePrettyWorker {
  local($element, $depth) = @_;
  local($pretty_string, $pretty_string_2, $i, $xml_doc, $node);
  local($last_child_element, $next_sibling);

  $pretty_string = "\n";
  for ($i=$depth ; $i > 0 ; $i--) {
    $pretty_string .= "    ";
  }

  $pretty_string_2 = "\n";
  for ($i= ($depth - 1) ; $i > 0 ; $i--) {
    $pretty_string_2 .= "    ";
  }

  $xml_doc = $element->getOwnerDocument;

  undef $last_child_element;
  foreach $node ($element->getChildNodes) {
    if ($node->getNodeType == ELEMENT_NODE) {
      $element->insertBefore($xml_doc->createTextNode($pretty_string),$node);
      $last_child_element = $node;
      ComponentDesc_MakePrettyWorker($node, $depth + 1);
    }
  }

  if ($last_child_element) {
    $next_sibling = $last_child_element->getNextSibling;
    $element->insertBefore($xml_doc->createTextNode($pretty_string_2),$next_sibling);
  }
}


sub ComponentDesc_MakePretty {
  local($element) = @_;

  $element->normalize;
  ComponentDesc_CompressWhiteSpace($element);
  ComponentDesc_MakePrettyWorker($element, 1);
}


sub ComponentDesc_Print {
  local($fileh, $component_desc) = @_;
  print($fileh $component_desc->toString);
}

sub ComponentDesc_SetAttributeValue {
  local($cd, $attrib, $value) = @_;
  local($child_node, $element, $text_node, $xml_doc);

  $xml_doc = $cd->getOwnerDocument;

  foreach  $child_node ($cd->getChildNodes) {
    if ($child_node->getNodeName eq "$attrib") {
      $element = $child_node;
      last;
    }
  }

  if (! $element) {
    $element = $xml_doc->createElement($attrib);
    $cd->appendChild($element);
  }


  foreach $child_node ($element->getChildNodes) {
    if ($child_node->getNodeType == TEXT_NODE) {
      $text_node = $child_node;
      last;
    }
  }

  if (!$text_node) {
    $text_node = $xml_doc->createTextNode();
    $element->appendChild($text_node);
  }
  $text_node->setData($value);
}

sub ComponentDesc_AppendAttributeNode {
  local($cd, $attrib, $value) = @_;
  local($element, $text_node, $xml_doc);

  $xml_doc = $cd->getOwnerDocument;

  $element = $xml_doc->createElement($attrib);
  $cd->appendChild($element);

  $text_node = $xml_doc->createTextNode();
  $element->appendChild($text_node);

  $text_node->setData($value);
}

sub ComponentDesc_New {
  local($xml_doc) = @_;
  local($cd);

  $cd = $xml_doc->createElement('ComponentDesc');

  return $cd;
}

sub ComponentDesc_AppendImport {
  local($cd, $import) = @_;
  local($xml_doc, $child_node, $import_element);

  $xml_doc = $cd->getOwnerDocument;
  foreach  $child_node ($cd->getChildNodes) {
    if ($child_node->getNodeName eq "Import") {
      $import_element = $child_node;
      last;
    }
  }
  if (! $import_element) {
    $import_element = $xml_doc->createElement('Import');
    $cd->appendChild($import_element);
  }

  $import_element->appendChild($import);
}
