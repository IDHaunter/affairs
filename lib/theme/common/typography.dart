import 'package:affairs/theme/theme_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle light = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: curITheme.textPrimary());

TextStyle regular = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, color: curITheme.textPrimary());

TextStyle medium = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: curITheme.textPrimary());

TextStyle semiBold = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: curITheme.textPrimary());

TextStyle bold = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: curITheme.textPrimary());

TextStyle extraBold = GoogleFonts.nunitoSans(
    fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, color: curITheme.textPrimary());

void rebuildTypography() {
  light = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: curITheme.textPrimary());

  regular = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, color: curITheme.textPrimary());

  medium = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: curITheme.textPrimary());

  semiBold = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: curITheme.textPrimary());

  bold = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: curITheme.textPrimary());

  extraBold = GoogleFonts.nunitoSans(
      fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, color: curITheme.textPrimary());
}