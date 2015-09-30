jQuery("#simulation")
  .on("click", ".s-c70b1ca8-e861-4e46-80bd-513186f38bf0 .click", function(event, data) {
    var jEvent, jFirer, cases;
    if(data === undefined) { data = event; }
    jEvent = jimEvent(event);
    jFirer = jEvent.getEventFirer();
    if(jFirer.is("#s-Button_1")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimNavigation",
                  "parameter": {
                    "target": "screens/80c91f7f-2b6c-4078-932d-be2382636b6d"
                  },
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    } else if(jFirer.is("#s-Button_2")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimNavigation",
                  "parameter": {
                    "target": "screens/80c91f7f-2b6c-4078-932d-be2382636b6d"
                  },
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    } else if(jFirer.is("#s-Image_1")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimNavigation",
                  "parameter": {
                    "target": "screens/77e48ece-a7ac-4b03-ac23-cf1dfe8482cf"
                  },
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    } else if(jFirer.is("#s-Label_21")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimShow",
                  "parameter": {
                    "target": "#s-changepic",
                    "transition": "slideup"
                  },
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    } else if(jFirer.is("#s-Button-black")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimChangeStyle",
                  "parameter": [ {
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black": {
                      "attributes": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#999999",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#999999",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#999999",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#999999",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px",
                        "font-size": "11.0pt",
                        "font-family": "Roboto-Regular,Arial"
                      },
                      "expressions": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black .valign": {
                      "attributes": {
                        "vertical-align": "middle",
                        "text-align": "center"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black span": {
                      "attributes": {
                        "color": "#999999",
                        "text-align": "center",
                        "text-decoration": "none",
                        "font-family": "Roboto-Regular,Arial",
                        "font-size": "11.0pt"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black": {
                      "attributes-ie": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#999999",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#999999",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#999999",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#999999",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px"
                      },
                      "expressions-ie": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  } ],
                  "exectype": "serial",
                  "delay": 0
                },
                {
                  "action": "jimPause",
                  "parameter": {
                    "pause": 300
                  },
                  "exectype": "serial",
                  "delay": 0
                },
                {
                  "action": "jimChangeStyle",
                  "parameter": [ {
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black": {
                      "attributes": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#404040",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#404040",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#404040",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#404040",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px",
                        "font-size": "11.0pt",
                        "font-family": "Roboto-Regular,Arial"
                      },
                      "expressions": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black .valign": {
                      "attributes": {
                        "vertical-align": "middle",
                        "text-align": "center"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black span": {
                      "attributes": {
                        "color": "#434343",
                        "text-align": "center",
                        "text-decoration": "none",
                        "font-family": "Roboto-Regular,Arial",
                        "font-size": "11.0pt"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black": {
                      "attributes-ie": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#404040",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#404040",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#404040",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#404040",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px"
                      },
                      "expressions-ie": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  } ],
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        },
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimNavigation",
                  "parameter": {
                    "target": "screens/e7a61ddd-1c9e-4960-85dd-2372024c160f"
                  },
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    } else if(jFirer.is("#s-Button-black_1")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimChangeStyle",
                  "parameter": [ {
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1": {
                      "attributes": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#999999",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#999999",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#999999",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#999999",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px",
                        "font-size": "11.0pt",
                        "font-family": "Roboto-Regular,Arial"
                      },
                      "expressions": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1 .valign": {
                      "attributes": {
                        "vertical-align": "middle",
                        "text-align": "center"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1 span": {
                      "attributes": {
                        "color": "#999999",
                        "text-align": "center",
                        "text-decoration": "none",
                        "font-family": "Roboto-Regular,Arial",
                        "font-size": "11.0pt"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1": {
                      "attributes-ie": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#999999",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#999999",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#999999",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#999999",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px"
                      },
                      "expressions-ie": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  } ],
                  "exectype": "serial",
                  "delay": 0
                },
                {
                  "action": "jimPause",
                  "parameter": {
                    "pause": 300
                  },
                  "exectype": "serial",
                  "delay": 0
                },
                {
                  "action": "jimChangeStyle",
                  "parameter": [ {
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1": {
                      "attributes": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#404040",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#404040",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#404040",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#404040",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px",
                        "font-size": "11.0pt",
                        "font-family": "Roboto-Regular,Arial"
                      },
                      "expressions": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1 .valign": {
                      "attributes": {
                        "vertical-align": "middle",
                        "text-align": "center"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1 span": {
                      "attributes": {
                        "color": "#434343",
                        "text-align": "center",
                        "text-decoration": "none",
                        "font-family": "Roboto-Regular,Arial",
                        "font-size": "11.0pt"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_1": {
                      "attributes-ie": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#404040",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#404040",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#404040",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#404040",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px"
                      },
                      "expressions-ie": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  } ],
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    } else if(jFirer.is("#s-Button-black_2")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimChangeStyle",
                  "parameter": [ {
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2": {
                      "attributes": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#999999",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#999999",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#999999",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#999999",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px",
                        "font-size": "11.0pt",
                        "font-family": "Roboto-Regular,Arial"
                      },
                      "expressions": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2 .valign": {
                      "attributes": {
                        "vertical-align": "middle",
                        "text-align": "center"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2 span": {
                      "attributes": {
                        "color": "#999999",
                        "text-align": "center",
                        "text-decoration": "none",
                        "font-family": "Roboto-Regular,Arial",
                        "font-size": "11.0pt"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2": {
                      "attributes-ie": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#999999",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#999999",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#999999",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#999999",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px"
                      },
                      "expressions-ie": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  } ],
                  "exectype": "serial",
                  "delay": 0
                },
                {
                  "action": "jimPause",
                  "parameter": {
                    "pause": 300
                  },
                  "exectype": "serial",
                  "delay": 0
                },
                {
                  "action": "jimChangeStyle",
                  "parameter": [ {
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2": {
                      "attributes": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#404040",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#404040",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#404040",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#404040",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px",
                        "font-size": "11.0pt",
                        "font-family": "Roboto-Regular,Arial"
                      },
                      "expressions": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2 .valign": {
                      "attributes": {
                        "vertical-align": "middle",
                        "text-align": "center"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2 span": {
                      "attributes": {
                        "color": "#434343",
                        "text-align": "center",
                        "text-decoration": "none",
                        "font-family": "Roboto-Regular,Arial",
                        "font-size": "11.0pt"
                      }
                    }
                  },{
                    "#s-c70b1ca8-e861-4e46-80bd-513186f38bf0 #s-Button-black_2": {
                      "attributes-ie": {
                        "border-top-width": "1px",
                        "border-top-style": "solid",
                        "border-top-color": "#404040",
                        "border-right-width": "1px",
                        "border-right-style": "solid",
                        "border-right-color": "#404040",
                        "border-bottom-width": "1px",
                        "border-bottom-style": "solid",
                        "border-bottom-color": "#404040",
                        "border-left-width": "1px",
                        "border-left-style": "solid",
                        "border-left-color": "#404040",
                        "border-radius": "8px 8px 8px 8px",
                        "padding-top": "4px",
                        "padding-right": "4px",
                        "padding-bottom": "4px",
                        "padding-left": "4px"
                      },
                      "expressions-ie": {
                        "width": "Math.max(375 - 1 - 1 - 4 - 4, 0) + 'px'",
                        "height": "Math.max(51 - 1 - 1 - 4 - 4, 0) + 'px'"
                      }
                    }
                  } ],
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        },
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimShow",
                  "parameter": {
                    "target": "#s-plain",
                    "transition": "slidedown"
                  },
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    }
  })
  .on("pageload", ".s-c70b1ca8-e861-4e46-80bd-513186f38bf0 .pageload", function(event, data) {
    var jEvent, jFirer, cases;
    if(data === undefined) { data = event; }
    jEvent = jimEvent(event);
    jFirer = jEvent.getEventFirer();
    if(jFirer.is("#s-Label_30")) {
      cases = [
        {
          "blocks": [
            {
              "actions": [
                {
                  "action": "jimSetValue",
                  "parameter": {
                    "target": "#s-Label_30",
                    "value": {
                      "action": "jimConcat",
                      "parameter": [ {
                        "action": "jimSubstring",
                        "parameter": [ {
                          "action": "jimSystemTime"
                        },"0","5" ]
                      }," PM" ]
                    }
                  },
                  "exectype": "serial",
                  "delay": 0
                }
              ]
            }
          ],
          "exectype": "serial",
          "delay": 0
        }
      ];
      event.data = data;
      jEvent.launchCases(cases);
    }
  });