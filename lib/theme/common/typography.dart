import 'package:affairs/theme/theme_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle light = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: theme.textPrimary());

TextStyle regular = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, color: theme.textPrimary());

TextStyle medium = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: theme.textPrimary());

TextStyle semibold = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: theme.textPrimary());

TextStyle bold = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: theme.textPrimary());

TextStyle extraBold = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, color: theme.textPrimary());

void rebuildTypography() {
  light = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: theme.textPrimary());

  regular = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, color: theme.textPrimary());

  medium = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: theme.textPrimary());

  semibold = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: theme.textPrimary());

  bold = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: theme.textPrimary());

  extraBold = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, color: theme.textPrimary());
}