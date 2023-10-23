(ch-consistency-formatting)=

Formatting

Formatting refers to how The Turing Way book is written and directly affects the book's appearance and presentation.

The Turing Way is hosted online as a Jupyter Book and uses the formatting recommendations as described in their documentation. Proper formatting ensures that The Turing Way is readable, accessible, and resembles a modular piece of work.

(ch-consistency-formatting-hr)=

Hard Requirements

The hard requirements in the consistency checklist ensure that The Turing Way prioritises accessibility, collaboration, readability and ease of use. The checks that deal with the The Turing Way's formatting include:

(ch-consistency-formatting-hr-markdown)=

Check 1: Use Markdown for creating your content

The Turing Way should be written in Markdown where possible, so that the Jupyter Book renders as intended.

Markdown x HTML

Parts of earlier chapters in The Turing Way were written in HTML, making some of their content hard to read.

For example, {ref}html-to-markdown depicts a table that was written in HTML.

---
name: html-to-markdown
alt: A screenshot of a poorly formatted table written in HTML. The table is squished together and does not have column or row borders. This makes it hard for a reader to decipher its meaning.
---
Content written in HTML may not render properly.
When reformatted to Markdown, the table became cleaner and easier to read:

---
name: html-to-markdown2
alt: A screenshot of a table converted to Markdown from HTML. The table becomes easier to read and understand when converted to Markdown.
---
Converting HTML to Markdown makes The Turing Way book easier to read.
Chapter content written in HTML are usually enclosed in tags which begin and end with angle brackets <>. W3Schools is an excellent resource for understanding what these tags mean, and Markdown reference guides, such as this cheatsheet, can help translate HTML formatting to Markdown. There are also helpful tools on the web, such as Turndown and CloudConvert, that convert HTML to Markdown with a single click.

Please note that if HTML is the only option for you to format your text the way you desire, you can use it only if the content in the online book can still be read and understood (use the Netlify preview in your PR to test). For example, superscripts and subscripts can be written in HTML because they always appear as intended. In addition, content like YouTube videos and tables with headers that span multiple columns or rows can be written in HTML.

:class: tip

_The Turing Way_ has a [book-wide stylesheet](https://github.com/the-turing-way/the-turing-way/blob/main/book/website/_static/book-stylesheet.css) that controls the look of content written in `HTML`.
If you include `HTML` in your contribution, ensure that your formatting includes the relevant classes and IDs from the stylesheet.

For example, if you want to add a YouTube video to your content using the `<iframe>` tag, wrap the `<iframe>` in a `<div>` tag, and give the `div` a `video-container` class as shown below.

<div class="video-container">
    <iframe>....</iframe>
</div>

This is also described in the {ref}Style Guide<ch-style-custom-styling-videos>.

Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/tv0HlVgxDdI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
Writing Checklists

When writing a new chapter for The Turing Way, you might include a Checklist subchapter that itemises key action points you want readers to take based on the chapter content. We recommend that you format your Checklist subchapters as unordered lists (checklist items denoted by [ ] do not render correctly):

# Checklist
- Item One
- Item Two
- Item Three

(ch-consistency-formatting-hr-headers)=

Check 2: Use headers in sequential order.

Non-consecutive headers refer to an increase in header levels of more than one. For example:

# Heading
### Another Heading
Such an increase of two header levels results in warnings when building The Turing Way locally. Ideally, all Markdown files should start with a level 1 heading and increase sequentially as appropriate:

# Heading
## Another Heading
Several files in The Turing Way book do not follow this convention. A list of such files can be found in this issue, and this PR is a great example of how to fix a file with non-consecutive headers.

Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/qq9QCrykdbw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
(ch-consistency-formatting-hr-labels)=

Check 3: Add labels to chapters, subchapters, sections, and images to enable cross-referencing.

Often, a chapter might refer to content from another chapter to explain concepts or expand on points. Cross-referencing facilitates this by ensuring that the referred content is easy to find with a simple click. This helps make The Turing Way more navigable and accessible.

{ref}Cross-referencing <ch-style-crossref> is discussed in detail in the {ref}ch-style. The subchapter explains what labels are, provides a naming convention for labels in The Turing Way, and gives several useful examples for how cross-referencing should be done.

Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/ikcjxjklLVg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
(ch-consistency-formatting-hr-images)=

Check 4: Use MyST for image formatting

Some figures and images in The Turing Way are embedded using Markdown syntax. While this works, it does not allow the images to adapt to the screen size of the device the book is read from.

Markedly Structured Text (MyST) is a flavour of Markdown that addresses this and enables responsive images in the The Turing Way.

It also allows the use of captions and alternative text (ALT text), which are the invisible image descriptions that are read aloud to readers of the The Turing Way who use a screen reader. If no ALT text is provided with an image, these users will be unable to understand the purpose of the image.

When writing ALT text, remember to:

Be descriptive - Adequately describe the image using its content and context for guidance. In doing so, there is no need to "announce" an image in your description (for example, using "illustration of" or "picture of") since screen readers will already do this.
Keep it as short as possible - Although a long description may be necessary for some images, it is better to keep them as short as possible. This ensures that the descriptions are easy to understand.
Please note that images included in The Turing Way book should be less than 1MB. This allows the book load faster, especially for readers who may have slow internet connections.

Please refer to the {ref}style guide <ch-style-figures> for examples on formatting images using MyST and adding ALT text to them. When including images in your contributions, it may be better to avoid the height parameter as the wrong value could make your image appear distorted on mobile devices. You should always check how your image looks in the Netlify preview of the book when you make a PR.

Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/upBiKLR_A5E" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
(ch-consistency-formatting-sr)=

Soft Requirements

Soft requirements help improve the overall look and feel of The Turing Way. When effected, these checks may go unnoticed, but they also contribute to making The Turing Way a polished piece of work. Soft requirements that deal with The Turing Way's formatting include:

(ch-consistency-formatting-sr-one)=

Check 1: Ensure that the names of chapters/subchapters are short and map exactly to how they are titled in the _toc.yml

Some chapters and subchapters in The Turing Way do not match their corresponding references in the book-wide table of contents that appears on the left of the webpage. This may be confusing for users, especially when the chapter/subchapter's reference in the table of contents significantly varies from the chapter/subchapter's name.

---
name: mismatched-title-toc
alt: A subchapter whose title differs from its reference in the table of contents. The title of the subchapter is 'Using Spreadsheets for Research Data', however in the table of contents, it is referred as 'Data Organisation in Spreadsheets'.
---
The title of this subchapter is 'Using Spreadsheets for Research Data', however the table of content refers to the same file as 'Data Organisation in Spreadsheets'.
In ensuring that The Turing Way's content passes this check, one recommendation to follow is to keep the titles short. When writing a new chapter, ensure that its title is short and has the same name in the table of contents. Similarly, when reviewing existing chapters, if its title and reference in the table of contents differ, make the shorter of the two the chapter's title, and update the _toc.yml if necessary.

The `_toc.yml` is the file where the book-wide table of contents for _The Turing Way_ lives.
Nonetheless, remember that the final title should adequately tell readers what to expect from a chapter or subchapter.

Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/HxcdqKJbCE4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
(ch-consistency-formatting-sr-two)=

Check 2: Ensure proper title-casing for headers

The titles of some chapters in The Turing Way do not use title-casing. Title-casing is a capitalisation style used to format the titles and headings of published works. Being a citeable reference for individuals seeking to carry out reproducible data science, titles and headings in The Turing Way should be title-cased.

Although The Turing Way does not follow a specific title capitalisation style, some general, non-exhaustive rules to consider include:

Capitalise principal or important words
Lowercase articles, conjunctions, and prepositions (unless when these are stressed)
Capitalise the first and last words
There are helpful tools, such as CapitalizeMyTitle and Title Case Converter, that can be used to title-case headers when writing your content. Furthermore, headers in The Turing Way can be run through these tools to ensure they follow title-casing conventions. They can then be replaced within chapters and in the _toc.yml as appropriate.

For example, In {ref}mismatched-title-toc above, Using spreadsheets for research data should be title-cased to Using Spreadsheets for Research Data.

Certain headers may not need to be title-cased depending on the context in which they are used. For example, because some of the headers in this chapter make up a checklist - they do not need to be title-cased.

Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/ET_LI5dwP9M" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
